<%@ Page Language="VB" AutoEventWireup="true" CodeFile="vb_SubmitAndCancel.aspx.vb" Inherits="HTMLEditor_vb_SubmitAndCancel" %>
<%@ Register
    Assembly="Obout.Ajax.UI"
    Namespace="Obout.Ajax.UI.HTMLEditor"
    TagPrefix="obout" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head runat="server">
    <title>Editor Sample</title>
    <style type="text/css">
            a {
                   font-size:10pt;font-family:Tahoma
            }
            a:hover {
                   color:crimson;
            }
            .tdText {
                    font:11px Verdana;
                    color:#333333;
            }
    </style>
</head>
<body style="font:12px Verdana;">
    <span class="tdText"><b>Obout.Ajax.UI.HTMLEditor controls</b> - <b>Editor</b> control with <b>Submit</b> and <b>Cancel</b> buttons</span>
    <br /><br />
    <form id="form1" runat="server">
        <asp:ScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />
        <obout:Editor runat="server" Id="editor" Height="500px" Width="100%">
            <TopToolbar Appearance="Lite" />
            <EditPanel OnCommand="onCommand"  />
            <BottomToolBar ShowCancelButton="true" ShowSubmitButton="true" />
        </obout:Editor>
    </form>
    <br /><br /><a href="Default.aspx?type=VBNET">< Back to examples</a>
</body>
</html>