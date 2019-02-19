<%@ Page Language="VB" AutoEventWireup="true" CodeFile="vb_jQueryMobilePage.aspx.vb" Inherits="Captcha_vb_jQueryMobilePage" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Ajax.UI.Captcha" Assembly="Obout.Ajax.UI" %>
<%@ Register TagPrefix="custom" Namespace="CustomCaptcha" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>test</title>
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.1/jquery.mobile-1.3.1.min.css" />
    <script type="text/javascript">
        function back() {
            location.href = "Default.aspx?type=VBNET";
            return false;
        }
    </script>
</head>
<body>
    <form id="frmMain" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="false">
        <Scripts>
            <asp:ScriptReference Path="http://code.jquery.com/jquery-1.10.2.min.js" ScriptMode="Release" />
            <asp:ScriptReference Path="http://code.jquery.com/mobile/1.3.1/jquery.mobile-1.3.1.min.js" ScriptMode="Release" />
        </Scripts>
    </asp:ScriptManager>
    <div data-role="page">
        <div data-role="content" style="width:300px">
            <div id="trCaptcha" runat="server" visible="true">
                <h1>Login</h1>
                <custom:MyCaptchaImage ID="ciCaptcha" runat="server" RelativeImageUrl="false" BackgroundNoise="Medium"
                    LineNoise="Medium" Visible="true" />
                <label for="txtCaptcha">Enter the above Captcha code:</label>
                <asp:TextBox runat="server" ID="txtCaptcha" Width="200" />
                <asp:RequiredFieldValidator ID="reqCaptcha" runat="server" ControlToValidate="txtCaptcha"
                    EnableClientScript="false" ValidationGroup="SubmitInfo" ErrorMessage="Enter the Captcha code"
                    Display="None" Enabled="true"></asp:RequiredFieldValidator>
                <obout:CaptchaValidator runat="server" ID="custCaptcha" ValidationGroup="SubmitInfo"
                    ControlToValidate="txtCaptcha" CaptchaImageID="ciCaptcha" ErrorMessage="Incorrect Captcha code."
                    Display="None" ForeColor="Red" Enabled="true" />
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="SubmitInfo"
                    EnableClientScript="False" DisplayMode="BulletList" ForeColor="Red" />
                <asp:Button runat="server" ID="btnConnect" Text="Login" OnClick="btnConnectClick"
                    class="button" CausesValidation="true" />
            </div>
            <div id="trLogged" runat="server" visible="false">
                <h1>You are logged</h1>
            </div>
        </div>
        <br /><br /><a href="javascript:back()">< Back to examples</a>
    </div>
    </form>
</body>
</html>
