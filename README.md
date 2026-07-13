## OpenBMC 测试自动化

**支持的接口**

- DMTF Redfish
- 带外 IPMI
- SSH 登录到 BMC 和主机操作系统
- [Legacy REST](https://github.com/openbmc/openbmc-test-automation/releases/tag/v4.0-stable)

**主要功能**

- 开机/关机
- 重启主机
- 复位 BMC
- BMC 和主机固件更新
- 电源管理
- 风扇控制
- HTX bootme
- XCAT 执行
- 网络
- IPMI 支持（通用及 DCMI 兼容）
- 恢复出厂设置
- RAS（可靠性、可用性和可维护性）
- Web UI 测试
- 安全启动
- SNMP（简单网络管理协议）
- 基于 Rsyslog 的远程日志记录
- LDAP（轻量级目录访问协议）
- 证书
- 本地用户管理（Redfish / IPMI）
- 日期和时间
- 事件日志
- PLDM（平台级数据模型，通过 pldmtool）

**调试支持**

- SOL 收集
- FFDC 收集
- 主机错误注入

## 安装设置指南

- [Robot Framework 安装说明](https://github.com/robotframework/robotframework/blob/master/INSTALL.rst)

- 请通过 pip 安装 OpenBMC 测试自动化所需的软件包及其依赖项

若使用 Python 3.x，请使用对应的 pip3 命令安装。注意：旧版的 Python 2.x 已不再维护

安装所需依赖：

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

安装 tox ：

```
    $ pip install -U tox
```

安装 expect (以 Ubuntu 为例)：

```
    $ sudo apt-get install expect
```

## OpenBMC 测试开发

下列文档包含 OpenBMC 测试代码开发与调试的详细信息

- [CONTRIBUTING.md](CONTRIBUTING.md)： 编码规范
- [代码检查工具](https://github.com/openbmc/openbmc-test-automation/blob/master/docs/code_standards_check.md)：
  用于检查常见拼写错误、语法及标准规范检查
- [Redfish 编码规范](https://github.com/openbmc/openbmc-test-automation/blob/master/docs/redfish_coding_guidelines.md)：
  Redfish 编码规范参考
- [REST-cheatsheet.md](https://github.com/openbmc/docs/blob/master/REST-cheatsheet.md)：
  Legacy REST 测试中常用 curl 命令的快速参考
- [REDFISH-cheatsheet.md](https://github.com/openbmc/docs/blob/master/REDFISH-cheatsheet.md)：
  Redfish 测试中常用 curl 命令的快速参考
- [README.md](https://github.com/openbmc/webui-vue/blob/master/README.md)：
  Web UI 设置参考
- [基于 mTLS 的 Redfish 请求](https://github.com/openbmc/openbmc-test-automation/blob/master/docs/redfish_request_via_mTLS.md)：
  基于 mTLS 发起 Redfish 请求的参考文档
- [公司 CLA 与个人 CLA](https://github.com/openbmc/docs/blob/master/CONTRIBUTING.md#submitting-changes-via-gerrit-server)：
  通过 Gerrit 服务器提交变更的相关说明

## OpenBMC 测试文档

- [OpenBMC 测试架构](https://github.com/openbmc/openbmc-test-automation/blob/master/docs/openbmc_test_architecture.md)：
  OpenBMC 测试架构参考
- [工具](https://github.com/openbmc/openbmc-test-automation/blob/master/docs/openbmc_test_tools.md)：
  辅助工具参考信息
- [固件更新](https://github.com/openbmc/openbmc-test-automation/blob/master/docs/code_update.md)：
 当前支持的 BMC 与 PNOR 更新
- [证书生成](https://github.com/openbmc/openbmc-test-automation/blob/master/docs/certificate_generate.md)：
  创建及安装 CA 签名证书的步骤
- [启动测试](https://github.com/openbmc/openbmc-test-automation/blob/master/docs/boot_test.md)：
  OpenBMC 启动测试

## 支持的系统架构

OpenBMC 测试框架已验证可运行于以下平台：

- POWER
- 运行 OpenBMC 固件栈的 x86 系统

## 测试环境准备步骤

用于验证环境准备是否已完成并可执行测试

- 下载 openbmc-test-automation 仓库：

  ```
  $ git clone https://github.com/openbmc/openbmc-test-automation
  $ cd openbmc-test-automation
  ```

- 运行基础环境验证测试：

  ```
  $ robot -v OPENBMC_HOST:xx.xx.xx.xx templates/test_openbmc_setup.robot
  ```

  其中 xx.xx.xx.xx 为 BMC 的主机名或 IP 地址

## 测试目录结构

openbmc-test-automation 根目录下包含多个子目录，分别存放测试套件、工具、模板等。这些子目录的分类如下：

`docs/`： 包含与 OpenBMC 相关的文档

`redfish/`： 包含 OpenBMC 功能验证的通用测试用例

`systest/`： 包含 HTX bootme 测试用例

`xcat/`： 包含 XCAT 自动化测试用例

`gui/test/`： 包含基于 AngularJS 的 Web 界面测试用例

`gui/gui_test/`： 包含基于 Vue.js 的 Web 用户界面测试用例

`pldm/`： 包含平台管理子系统的测试用例（base、bios、fru、platform、OEM）

`snmp/`： 包含 SNMP（简单网络管理协议）配置测试用例

`openpower/`： 包含基于 OpenPOWER 系统的测试用例

`tools/`： 包含各类工具

`templates/`： 包含示例代码和环境搭建测试

`test_list/`： 包含用于跳过测试用例（如 skip_test、skip_test_extended 等）或进行分组（如 HW_CI、CT_basic_run 等）的参数文件

## Redfish 测试目录结构

OpenBMC 正逐步采用 DMTF Redfish，这是一项开放的行业标准规范与 Schema 定义，
旨在满足最终用户对可扩展平台硬件实现简洁、现代化且安全管理的需求。

`redfish/`： 包含 OpenBMC 上支持的 DMTF Redfish 相关功能测试用例

`redfish/extended/`： 包含组合型 DMTF Redfish 相关功能测试用例。部分测试用例后续将被弃用

注意：开发中的测试参数 -v REDFISH_SUPPORT_TRANS_STATE:1 可用于强制测试套件仅以 Redfish 模式执行。

## 快速入门

运行 openbmc-automation 前，需先安装所需的 Python 依赖包，
以便通过 tox（版本需不低于 2.3.1）或 Robot CLI 命令来执行测试。

**Robot 命令行**

- 执行 redfish/ 和 ipmi/ 下的所有测试套件：

  ```
  $ robot -v OPENBMC_HOST:xx.xx.xx.xx  redfish  ipmi
  ```

- 执行单个测试套件：

  ```
  $ robot -v OPENBMC_HOST:xx.xx.xx.xx redfish/extended/test_basic_ci.robot
  ```

- 初始化测试执行期间使用的变量：

  用户可通过环境变量预声明：

  ```
  $ export OPENBMC_HOST=<openbmc machine IP address/hostname>
  $ export OPENBMC_USERNAME=<openbmc username>
  $ export OPENBMC_PASSWORD=<openbmc password>
  $ export IPMI_COMMAND=<Dbus/External>
  ```

  或者，用户也可在 CLI 命令中通过 robot 变量传入：

  ```
  -v OPENBMC_HOST:<openbmc machine IP address/hostname>
  -v OPENBMC_USERNAME:<openbmc username>
  -v OPENBMC_PASSWORD:<openbmc password>
  ```

- 在 qemu 中进行测试：

  设置额外的环境变量：

  ```
  $ export SSH_PORT=<ssh port number>
  $ export HTTPS_PORT=<https port number>
  ```

  运行 QEMU CI 测试套件：

  ```
  $ OPENBMC_HOST=xx.xx.xx.xx SSH_PORT=<port number> HTTPS_PORT=<port number> robot -A test_lists/QEMU_CI  redfish/ ipmi/
  ```

- 运行测试：

- 如何运行单个测试：

  ```
  $ OPENBMC_HOST=xx.xx.xx.xx tox -e default -- --include Test_SSH_And_IPMI_Connections redfish/extended/test_basic_ci.robot
  ```

- 如何运行 CI 和 CT 分组测试：

 默认CI测试分组列表：

  ```
  $ OPENBMC_HOST=xx.xx.xx.xx tox -e default -- --argumentfile test_lists/HW_CI  redfish/  ipmi/
  ```

  默认 CI 冒烟测试分组列表：

  ```
  $ OPENBMC_HOST=xx.xx.xx.xx tox -e default -- --argumentfile test_lists/CT_basic_run  redfish/  ipmi/
  ```

- 所支持机型的测试排除列表：

  ```
  Witherspoon:  test_lists/skip_test_witherspoon
  ```

  使用排除列表（以 Witherspoon 为例）

  ```
  $ robot -v OPENBMC_HOST:xx.xx.xx.xx -A test_lists/skip_test_witherspoon  redfish/ ipmi/
  ```

- 通过 Robot CLI 接口运行 IPMI 测试：

  仅运行带外 IPMI 测试：

  ```
  $ robot -v IPMI_COMMAND:External -v OPENBMC_HOST:xx.xx.xx.xx --argumentfile test_lists/witherspoon/skip_inband_ipmi  ipmi/
  ```

  仅运行带内 IPMI 测试：

  ```
  $ robot -v IPMI_COMMAND:Inband -v OPENBMC_HOST:xx.xx.xx.xx -v OS_HOST:xx.xx.xx.xx -v OS_USERNAME:xxxx -v OS_PASSWORD:xxxx --argumentfile test_lists/witherspoon/skip_oob_ipmi  ipmi/
  ```

- 通过 Robot CLI 接口运行 GUI 测试：

  默认情况下，GUI 使用 Firefox 浏览器并以无头模式运行。使用 Chrome 浏览器并以 header 模式运行的示例如下：

  ```
  $ robot -v OPENBMC_HOST:xx.xx.xx.xx -v GUI_BROWSER:gc -v GUI_MODE:header gui/test/
  ```

  运行 GUI 默认 CI 测试组：

  ```
  $ robot -v OPENBMC_HOST:xx.xx.xx.xx --argumentfile test_lists/BMC_WEB_CI gui/test/
  ```

- 通过 Robot CLI 接口运行 LDAP 测试：

  使用 LDAP 测试功能前，请确保已在 LDAP 服务器上创建了相应的 LDAP 用户及组
  注意：LDAP 用户/组的创建方式多样，具体取决于 LDAP 服务器类型。OpenLDAP 常用方式为 ldapadd / ldapmodify，参考：
  https://linux.die.net/man/1/ldapadd ；ldapsearch 参考：https://linux.die.net/man/1/ldapsearch 。
  Microsoft ADS 参考：
  https://searchwindowsserver.techtarget.com/definition/Microsoft-Active-Directory-Domain-Services-AD-DS

  调用 LDAP 测试的格式如下：

  ```
  $ cd redfish/account_service/
  $ robot -v OPENBMC_HOST:xx.xx.xx.xx -v LDAP_SERVER_URI:<ldap(s)//LDAP Hostname / IP> -v LDAP_BIND_DN:<LDAP Bind DN> -v LDAP_BASE_DN:<LDAP Base DN> -v LDAP_BIND_DN_PASSWORD:<LDAP Bind password> -v LDAP_SEARCH_SCOPE:<LDAP search scope> -v LDAP_SERVER_TYPE:<LDAP server type> -v LDAP_USER:<LDAP user-id> -v LDAP_USER_PASSWORD:<LDAP PASSWORD> -v GROUP_NAME:<Group Name> -v GROUP_PRIVILEGE:<Privilege>  ./test_ldap_configuration.robot
  ```

- 主机 CPU 架构

  openbmc-test-automation 框架默认主机 CPU 为 POWER 架构。若主机 CPU 为 x86，
  请在 CLI 命令中添加 -v PLATFORM_ARCH_TYPE:x86 变量设置，或设置环境变量：

  ```
  $ export PLATFORM_ARCH_TYPE=x86
  ```

**Jenkins 任务 tox 命令**

- HW CI tox 命令：

  ```
  $ OPENBMC_HOST=xx.xx.xx.xx tox -e default -- --argumentfile test_lists/HW_CI  redfish/  ipmi/
  ```
