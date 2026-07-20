*** Settings ***
Documentation    测试Redfish会话以及连接问稳定性

Resource         ../../lib/bmc_redfish_utils.robot
Resource         ../../lib/openbmc_ffdc.robot

Suite Setup      Set Redfish Delete Session Flag  ${0}
Suite Teardown   Run Keywords  Set Redfish Delete Session Flag  ${1}  AND  Redfish.Logout
Test Setup       Printn
Test Teardown    FFDC On Test Case Fail

Test Tags        Sessions_Connection

*** Variables ***

${DURATION}                 6h
${INTERVAL}                 30s
${REBOOT_INTERVAL}          30m
# OpenBMC 的 SSH 走的是 systemd 的 socket 激活机制，所以真正起作用的限制是 socket 里的 MaxConnections 参数
# 默认情况下这个值设成 64，也就是说同时最多只能保持 63 个活跃会话，等第 64 个连接进来时就会直接失败。
${SSH_SESSION_LIMIT}        63

*** Test Cases ***

Create Session And Check Connection Stability
    [Documentation]  Send heartbeat on session continuously and verify connection stability.
    [Tags]  Create_Session_And_Check_Connection_Stability
    [Setup]  Redfish.Logout

    # Clear old session and start new session.
    Redfish.Login

    Repeat Keyword  ${DURATION}  Send Heartbeat

Create Session And Check Connection Stability On Reboot
    [Documentation]  Create Session And Check Connection Stability On Reboot
    [Tags]  Create_Session_And_Check_Connection_Stability_On_Reboot
    [Setup]  Redfish.Logout

    # Clear old session and start new session.
    Redfish.Login

    Repeat Keyword  ${DURATION}  Check Connection On Reboot

Verify BMC Session Service Limits for SSH Connections
    [Documentation]  Verify BMC Session Service limits for SSH connections.
    [Tags]    Verify_BMC_Session_Service_Limits_for_SSH_Connections
    [Setup]   SSHLibrary.Close All Connections
    [Teardown]  Run Keywords  SSHLibrary.Close All Connections  AND
    ...    Delete All Redfish Sessions

    # Open SSH sessions up to limit and verify each login is successful.
    FOR  ${i}  IN RANGE  ${SSH_SESSION_LIMIT}
        ${status}=  Run Keyword And Return Status
        ...  Open Connection And Log In  ${OPENBMC_USERNAME}  ${OPENBMC_PASSWORD}  host=${OPENBMC_HOST}
        Should Be True  ${status}
        Sleep  1s
    END

    ${ssh_connections}=  SSHLibrary.Get Connections
    ${ssh_count}=  Get Length  ${ssh_connections}
    Log  SSH sessions created: ${ssh_count}
    Should Be Equal As Integers  ${ssh_count}  ${SSH_SESSION_LIMIT}

    # Verify one additional SSH login beyond limit fails.
    ${extra_status}=  Run Keyword And Return Status
    ...  Open Connection And Log In  ${OPENBMC_USERNAME}  ${OPENBMC_PASSWORD}  host=${OPENBMC_HOST}
    Should Be Equal  ${extra_status}  ${False}

*** Keywords ***

Send Heartbeat
    [Documentation]  Send heartbeat to BMC.

    Redfish.Get Attribute  ${REDFISH_NW_PROTOCOL_URI}  HostName
    Sleep  ${INTERVAL}


Check Connection On Reboot
    [Documentation]  Send heartbeat on BMC reboot.

    # 重启 BMC
    Redfish OBMC Reboot (Off)

    # Verify session is still active and no issues on connection after reboot.
    Repeat Keyword  ${REBOOT_INTERVAL}  Send Heartbeat
