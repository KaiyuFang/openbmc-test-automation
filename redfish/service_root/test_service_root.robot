*** Settings ***
Documentation    针对 Redfish 会话服务及根服务入口的响应测试

Resource         ../../lib/bmc_redfish_resource.robot
Resource         ../../lib/openbmc_ffdc.robot

Test Teardown    FFDC On Test Case Fail
Test Setup       Printn

Test Tags        Service_Root

*** Test Cases ***

Redfish Login And Logout
    [Documentation]  登录 BMC Web 并退出登录
    [Tags]  Redfish_Login_And_Logout

    Redfish.Login
    Redfish.Logout


GET Redfish Hypermedia Without Login
    [Documentation]  未登录时访问 Redfish 根服务入口
    [Tags]  GET_Redfish_Hypermedia_Without_Login
    [Setup]  Redfish.Logout
    [Template]  GET And Verify Redfish Response

    # Expect status      Resource URL Path
    ${HTTP_OK}           /redfish
    ${HTTP_OK}           /redfish/v1


GET Redfish SessionService Without Login
    [Documentation]  未登录时访问 /redfish/v1/SessionService
    [Tags]  GET_Redfish_SessionService_Without_Login
    [Setup]  Redfish.Logout

    Redfish.Get  /redfish/v1/SessionService
    ...  valid_status_codes=[${HTTP_UNAUTHORIZED}]


GET Redfish Resources With Login
    [Documentation]   登录 BMC Web 后，获取有效资源
    [Tags]  GET_Redfish_Resources_With_Login
    [Setup]  Redfish.Login
    [Template]  GET And Verify Redfish Response

    # 预期状态码          资源 URL 路径
    ${HTTP_OK}           /redfish/v1/SessionService
    ${HTTP_OK}           /redfish/v1/AccountService
    ${HTTP_OK}           /redfish/v1/Systems/${SYSTEM_ID}
    ${HTTP_OK}           /redfish/v1/Chassis/${CHASSIS_ID}
    ${HTTP_OK}           /redfish/v1/Managers/${MANAGER_ID}
    ${HTTP_OK}           /redfish/v1/UpdateService


Redfish Login Using Invalid Token
    [Documentation]  使用无效token登录 BMC Web
    [Tags]  Redfish_Login_Using_Invalid_Token

    Create Session  openbmc  ${AUTH_URI}

    # 示例: "X-Auth-Token: 3la1JUf1vY4yN2dNOwun"
    VAR  &{headers} =  Content-Type=application/json
    ...  X-Auth-Token=deadbeef

    ${resp} =  GET On Session
    ...  openbmc  ${REDFISH_SESSION_URI}  headers=${headers}
    ...  expected_status=${HTTP_UNAUTHORIZED}

    Should Be Equal As Strings  ${resp.status_code}  ${HTTP_UNAUTHORIZED}


Verify Redfish Invalid URL Response Code
    [Documentation]  登录 BMC Web 后，验证无效 URL 的响应码
    [Tags]  Verify_Redfish_Invalid_URL_Response_Code

    Redfish.Login
    Wait Until Keyword Succeeds  1 min  30 sec
    ...  Redfish.Get  /redfish/v1/idontexist  valid_status_codes=[${HTTP_NOT_FOUND}]
    Redfish.Logout


Delete Redfish Session Using Valid Login
    [Documentation]  使用新登录获取的有效会话，删除已有会话
    [Tags]  Delete_Redfish_Session_Using_Valid_Login

    Redfish.Login
    ${session_info} =  Get Redfish Session Info

    Redfish.Login

    # Example o/p:
    # [{'@odata.id': '/redfish/v1/SessionService/Sessions/bOol3WlCI8'},
    #  {'@odata.id': '/redfish/v1/SessionService/Sessions/Yu3xFqjZr1'}]
    ${resp_list} =  Redfish_Utils.List Request
    ...  ${REDFISH_SESSION_URI}

    Redfish.Delete  ${session_info["location"]}

    ${resp} =  Redfish_Utils.List Request  ${REDFISH_SESSION_URI}
    List Should Not Contain Value  ${resp}  ${session_info["location"]}


Redfish Login Via SessionService
    [Documentation]  通过 SessionService 登录 BMC
    [Tags]   Redfish_Login_Via_SessionService

    Create Session  openbmc  https://${OPENBMC_HOST}:${HTTPS_PORT}
    VAR  &{headers} =  Content-Type=application/json
    VAR  ${data} =  {"UserName":"${OPENBMC_USERNAME}", "Password":"${OPENBMC_PASSWORD}"}

    ${resp} =  POST On Session  openbmc  ${REDFISH_SESSION_URI}  data=${data}  headers=${headers}
    Should Be Equal As Strings  ${resp.status_code}  ${HTTP_CREATED}

    VAR  &{headers} =  Content-Type=application/json
    ...  X-Auth-Token=${resp.headers["X-Auth-Token"]}
    ${resp} =  DELETE On Session  openbmc  ${REDFISH_SESSION_URI}${/}${resp.json()["Id"]}  headers=${headers}
    Should Be Equal As Strings  ${resp.status_code}  ${HTTP_OK}


Verify Redfish Unresponsive URL paths
    [Documentation]  /redfish/v1 下 URL 路径预期都有响应
    [Tags]   Verify_Redfish_Unresponsive_URL_paths

    Redfish.Login
    ${resource_list}  ${dead_resources} =  Enumerate Request  /redfish/v1  include_dead_resources=True
    Redfish.Logout
    Valid Length  dead_resources  max_length=0


Verify Service Root Unsupported Methods
    [Documentation]  验证服务根节点不支持的方法
    [Tags]  Verify_Service_Root_Unsupported_Methods

    Verify Supported And Unsupported Methods  uri=${REDFISH_BASE_URI}


*** Keywords ***

GET And Verify Redfish Response
    [Documentation]   发起 GET 请求并校验响应
    [Arguments]  ${valid_status_codes}  ${resource_path}

    # Description of argument(s):
    # valid_status_codes            A comma-separated list of acceptable
    #                               status codes (e.g. 200).
    # resource_path                 Redfish resource URL path.

    Redfish.Get  ${resource_path}
    ...  valid_status_codes=[${valid_status_codes}]
