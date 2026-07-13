## OpenBMC 测试自动化

**支持的接口**

- DMTF Redfish
- 带外 IPMI
- SSH 到 BMC 和主机操作系统
- [Legacy REST](https://github.com/openbmc/openbmc-test-automation/releases/tag/v4.0-stable)

**主要功能**

- 开机/关机
- 重启主机
- 复位 BMC
- BMC 和主机固件更新
- 电源管理
- 风扇控制
- HTX bootme (用于 OpenPOWER 架构的服务器硬件测试)
- XCAT 执行(BMC批量管理工具的集成测试)
- 网络
- IPMI 支持（通用及 DCMI 兼容）
- 恢复出厂设置
- RAS (可靠性、可用性和可维护性)
- Web UI 测试
- 安全启动
- SNMP (简单网络管理协议)
- 基于Rsyslog的远程日志记录
- LDAP (轻量级目录访问协议)
- 证书
- 本地用户管理（Redfish / IPMI）
- 日期和时间
- 事件日志
- 基于 pldmtool 的 PLDM（平台级数据模型）

**调试支持**

- SOL 收集
- FFDC 收集
- 主机注错

## 安装设置指南

- [Robot Framework 安装说明](https://github.com/robotframework/robotframework/blob/master/INSTALL.rst)

- 通过 pip 安装 OpenBMC 测试自动化所需的软件包及其依赖项

若使用 Python 3.x，请使用对应的 pip3 命令安装。注意：旧版的Python 2.x 已不再维护

安装所需依赖:

```
    $ pip install -r requirements.txt
```

可选软件包，但使用 redfish/dmtf_tools/ 时必须安装

```
    $ pip install -r requirements_optional.txt
```

克隆 openbmc-test-automation 仓库后即可找到该文件

关于 Web UI（图形界面）测试环境搭建，请遵循《OpenBMC GUI 测试设置指南》中的操作说明
注意：若未在环境中完成上述设置，gui/ 目录下的 GUI 测试用例将无法运行
[OpenBMC GUI 测试设置指南](https://github.com/openbmc/openbmc-test-automation/blob/master/docs/gui_setup_reference.md)

安装 tox:

```
    $ pip install -U tox
```

安装 expect (以Ubuntu为例):

```
    $ sudo apt-get install expect
```

## OpenBMC 测试开发

下列文档包含 OpenBMC 测试代码开发与调试的详细信息

- [MAINTAINERS](OWNERS): OpenBMC 测试代码维护者信息
- [CONTRIBUTING.md](CONTRIBUTING.md): 编码规范
- [代码检查工具](https://github.com/openbmc/openbmc-test-automation/blob/master/docs/code_standards_check.md):
  用于检查常见拼写错误、语法及标准规范检查
- [Redfish 编码规范](https://github.com/openbmc/openbmc-test-automation/blob/master/docs/redfish_coding_guidelines.md):
  Redfish 编码规范参考
- [REST-cheatsheet.md](https://github.com/openbmc/docs/blob/master/REST-cheatsheet.md):
  Legacy REST 测试中常用 curl 命令的快速参考
- [REDFISH-cheatsheet.md](https://github.com/openbmc/docs/blob/master/REDFISH-cheatsheet.md):
  Redfish 测试中常用 curl 命令的快速参考
- [README.md](https://github.com/openbmc/webui-vue/blob/master/README.md): Web
  Web UI 设置参考
- [基于 mTLS 的 Redfish 请求](https://github.com/openbmc/openbmc-test-automation/blob/master/docs/redfish_request_via_mTLS.md):
  基于mTLS发起 Redfish 请求的参考文档
- [公司 CLA 与个人 CLA](https://github.com/openbmc/docs/blob/master/CONTRIBUTING.md#submitting-changes-via-gerrit-server):
  通过 Gerrit 服务器提交变更的相关说明

## OpenBMC 测试文档

- [OpenBMC 测试架构](https://github.com/openbmc/openbmc-test-automation/blob/master/docs/openbmc_test_architecture.md):
  OpenBMC 测试架构参考
- [工具](https://github.com/openbmc/openbmc-test-automation/blob/master/docs/openbmc_test_tools.md):
  辅助工具参考信息
- [代码更新](https://github.com/openbmc/openbmc-test-automation/blob/master/docs/code_update.md):
 当前支持的 BMC 与 PNOR(Processor NOR Flash) 更新
- [证书生成](https://github.com/openbmc/openbmc-test-automation/blob/master/docs/certificate_generate.md):
  创建及安装 CA 签名证书的步骤
- [启动测试](https://github.com/openbmc/openbmc-test-automation/blob/master/docs/boot_test.md):
  OpenBMC启动测试

## 支持的系统架构

OpenBMC 测试框架已验证可运行于以下平台：

- POWER
- 运行 OpenBMC 固件栈的 x86 系统

## Testing Setup Steps

To verify the installation setup is completed and ready to execute.

- Download the openbmc-test-automation repository:

  ```
  $ git clone https://github.com/openbmc/openbmc-test-automation
  $ cd openbmc-test-automation
  ```

- Execute basic setup test run:

  ```
  $ robot -v OPENBMC_HOST:xx.xx.xx.xx templates/test_openbmc_setup.robot
  ```

  where xx.xx.xx.xx is the BMC hostname or IP.

## Test Layout

There are several sub-directories within the openbmc-test-automation base which
contain test suites, tools, templates, etc. These sub-directories are classified
as follows:

`docs/`: Contains the documentation related to OpenBMC.

`redfish/`: Contains the general test cases for OpenBMC stack functional
verification.

`systest/`: Contains test cases for HTX bootme testing.

`xcat/`: Contains test cases for XCAT automation.

`gui/test/`: Contains test cases for testing web-based interface built on
AngularJS.

`gui/gui_test/`: Contains test cases for testing web-based user interface built
on Vue.js.

`pldm/`: Contains test cases for platform management subsystem (base, bios, fru,
platform, OEM).

`snmp/`: Contains test cases for SNMP (Simple Network Management Protocol)
configuration testing.

`openpower/`: Contains test cases for an OpenPOWER based system.

`tools/`: Contains various tools.

`templates/`: Contains sample code examples and setup testing.

`test_list/`: Contains the argument files used for skipping test cases (e.g
"skip_test", "skip_test_extended", etc.) or grouping them (e.g "HW_CI",
"CT_basic_run", etc.).

## Redfish Test Layout

OpenBMC is moving steadily towards DTMF Redfish, which is an open industry
standard specification and schema that meets the expectations of end users for
simple, modern and secure management of scalable platform hardware.

`redfish/`: Contains test cases for DMTF Redfish-related feature supported on
OpenBMC.

`redfish/extended/`: Contains test cases for combined DMTF Redfish-related
feature supported on OpenBMC. Some of the test will be deprecated.

Note: Work in progress test development parameter
`-v REDFISH_SUPPORT_TRANS_STATE:1` to force the test suites to execute in
redfish mode only.

## Quickstart

To run openbmc-automation first you need to install the prerequisite Python
packages which will help to invoke tests through tox (Note that tox version
2.3.1 or greater is required) or via Robot CLI command.

**Robot Command Line**

- Execute all test suites for `redfish/` and `ipmi/`:

  ```
  $ robot -v OPENBMC_HOST:xx.xx.xx.xx  redfish  ipmi
  ```

- Execute a test suite:

  ```
  $ robot -v OPENBMC_HOST:xx.xx.xx.xx redfish/extended/test_basic_ci.robot
  ```

- Initialize the following test variables which will be used during test
  execution:

  User can forward declare as environment variables:

  ```
  $ export OPENBMC_HOST=<openbmc machine IP address/hostname>
  $ export OPENBMC_USERNAME=<openbmc username>
  $ export OPENBMC_PASSWORD=<openbmc password>
  $ export IPMI_COMMAND=<Dbus/External>
  ```

  or

  User can input as robot variables as part of the CLI command:

  ```
  -v OPENBMC_HOST:<openbmc machine IP address/hostname>
  -v OPENBMC_USERNAME:<openbmc username>
  -v OPENBMC_PASSWORD:<openbmc password>
  ```

- Testing in qemu:

  Set extra environment variables:

  ```
  $ export SSH_PORT=<ssh port number>
  $ export HTTPS_PORT=<https port number>
  ```

  Run the QEMU CI test suite:

  ```
  $ OPENBMC_HOST=xx.xx.xx.xx SSH_PORT=<port number> HTTPS_PORT=<port number> robot -A test_lists/QEMU_CI  redfish/ ipmi/
  ```

- Run tests:

- How to run an individual test:

  ```
  $ OPENBMC_HOST=xx.xx.xx.xx tox -e default -- --include Test_SSH_And_IPMI_Connections redfish/extended/test_basic_ci.robot
  ```

- How to run CI and CT bucket test:

  Default CI test bucket list:

  ```
  $ OPENBMC_HOST=xx.xx.xx.xx tox -e default -- --argumentfile test_lists/HW_CI  redfish/  ipmi/
  ```

  Default CI smoke test bucket list:

  ```
  $ OPENBMC_HOST=xx.xx.xx.xx tox -e default -- --argumentfile test_lists/CT_basic_run  redfish/  ipmi/
  ```

- Exclude test list for supported systems:

  ```
  Witherspoon:  test_lists/skip_test_witherspoon
  ```

  Using the exclude lists (example for Witherspoon)

  ```
  $ robot -v OPENBMC_HOST:xx.xx.xx.xx -A test_lists/skip_test_witherspoon  redfish/ ipmi/
  ```

- Run IPMI tests via robot CLI interface:

  Running only out-of-band IPMI tests:

  ```
  $ robot -v IPMI_COMMAND:External -v OPENBMC_HOST:xx.xx.xx.xx --argumentfile test_lists/witherspoon/skip_inband_ipmi  ipmi/
  ```

  Running only inband IPMI tests:

  ```
  $ robot -v IPMI_COMMAND:Inband -v OPENBMC_HOST:xx.xx.xx.xx -v OS_HOST:xx.xx.xx.xx -v OS_USERNAME:xxxx -v OS_PASSWORD:xxxx --argumentfile test_lists/witherspoon/skip_oob_ipmi  ipmi/
  ```

- Run GUI tests via robot CLI interface:

  By default, GUI runs with Firefox browser and headless mode. Example with
  Chrome browser and header mode:

  ```
  $ robot -v OPENBMC_HOST:xx.xx.xx.xx -v GUI_BROWSER:gc -v GUI_MODE:header gui/test/
  ```

  Run GUI default CI test bucket:

  ```
  $ robot -v OPENBMC_HOST:xx.xx.xx.xx --argumentfile test_lists/BMC_WEB_CI gui/test/
  ```

- Run LDAP tests via robot CLI interface:

  Before using LDAP test functions, be sure appropriate LDAP user(s) and
  group(s) have been created on your LDAP server. Note: There are multiple ways
  to create LDAP users / groups and all depend on your LDAP server. One common
  way for openldap is ldapadd / ldapmodify refer
  https://linux.die.net/man/1/ldapadd For ldapsearch, refer to
  "https://linux.die.net/man/1/ldapsearch". Microsoft ADS: refer to
  https://searchwindowsserver.techtarget.com/definition/Microsoft-Active-Directory-Domain-Services-AD-DS

  The format to invoke LDAP test is as follows:

  ```
  $ cd redfish/account_service/
  $ robot -v OPENBMC_HOST:xx.xx.xx.xx -v LDAP_SERVER_URI:<ldap(s)//LDAP Hostname / IP> -v LDAP_BIND_DN:<LDAP Bind DN> -v LDAP_BASE_DN:<LDAP Base DN> -v LDAP_BIND_DN_PASSWORD:<LDAP Bind password> -v LDAP_SEARCH_SCOPE:<LDAP search scope> -v LDAP_SERVER_TYPE:<LDAP server type> -v LDAP_USER:<LDAP user-id> -v LDAP_USER_PASSWORD:<LDAP PASSWORD> -v GROUP_NAME:<Group Name> -v GROUP_PRIVILEGE:<Privilege>  ./test_ldap_configuration.robot
  ```

- Host CPU architecture

  By default openbmc-test-automation framework assumes that host CPU is based on
  the POWER architecture. If your host CPU is x86 add
  `-v PLATFORM_ARCH_TYPE:x86` variable setting to your CLI commands or set an
  environment variable:

  ```
  $ export PLATFORM_ARCH_TYPE=x86
  ```

**Jenkins jobs tox commands**

- HW CI tox command:

  ```
  $ OPENBMC_HOST=xx.xx.xx.xx tox -e default -- --argumentfile test_lists/HW_CI  redfish/  ipmi/
  ```
