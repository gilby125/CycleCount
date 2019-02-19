<%@ Page Language="C#" AutoEventWireup="true" CodeFile="cs_force_spellchecking.aspx.cs" Inherits="HTMLEditor_cs_force_spellchecking" %>
<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.HTMLEditor" TagPrefix="obout" %>
<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.HTMLEditor.Popups" TagPrefix="obout" %>
<%@ Register Assembly="Obout.Ajax.UI" TagPrefix="obout" Namespace="Obout.Ajax.UI.HTMLEditor.ToolbarButton" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head id="Head1" runat="server">
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
    <script type="text/javascript">
        // flag whether the spell checker is called on submit
        var spellCheckOnSubmit = false;
        // this function is called on page load
        function pageLoad(sender, e) {
            // 'initializeRequest ' handler
            function initializeRequest(sender, e) {
                // whether to call spell checker
                if (!window.spellCheckOnSubmit && $get("<%=cbForceSpellCheck.ClientID%>").checked) {
                    // editor client-side object
                    var editor = $find("<%= ContentEditor.ClientID %>");
                    // edit panel
                    var editPanel = editor.get_editPanel();
                    // allow submit in 'Design' mode only
                    if (editPanel.get_activeMode() == Obout.Ajax.UI.HTMLEditor.ActiveModeType.Design) {
                        // with delay
                        setTimeout(function () {
                            // call spell checker
                            callButtonMethod("SpellCheck");
                            // set the flag
                            window.spellCheckOnSubmit = true;
                            // spell checker client-side object
                            var spellChecker = $find("<%= spellChecker.ClientID %>");
                            // save its inner handler for 'OK' button
                            spellChecker.okCallback_original = spellChecker.okCallback;
                            // save its inner handler for 'Cancel' button
                            spellChecker.cancelCallback_original = spellChecker.cancelCallback;
                            // override the 'OK' handler
                            spellChecker.okCallback = function (contentWindow) {
                                // call the original method
                                this.okCallback_original(contentWindow);
                                // while spell checking the content could be changed
                                // so we reset the EditPanel's inner property
                                editPanel._contentPrepared = false;
                                // force postback
                                __doPostBack("<%=Submit1.UniqueID%>", "");
                                // reset flag
                                window.spellCheckOnSubmit = false;
                            };
                            // override the 'Cancel' handler
                            spellChecker.cancelCallback = function (contentWindow) {
                                // reset flag
                                window.spellCheckOnSubmit = false;
                                // call the original method
                                this.cancelCallback_original(contentWindow);
                            };
                        }, 0);
                    } else {
                        alert("Switch Editor to 'Design' mode.");
                    }
                    // cancel the request
                    e.set_cancel(true);
                    return;
                }
                // remove itself
                Sys.WebForms.PageRequestManager.getInstance().remove_initializeRequest(initializeRequest);
                // show the "wait" image
                $get("wait").style.visibility = "visible";
            }
            // add the 'initializeRequest' handler
            Sys.WebForms.PageRequestManager.getInstance().add_initializeRequest(initializeRequest);
            // hide the "wait" image
            var wait = $get("wait");
            wait.style.visibility = "hidden";
            // set the image's height
            wait.style.height = document.getElementById("<%=Submit1.ClientID%>").offsetHeight + "px";
            // reset flag
            window.spellCheckOnSubmit = false;
        }
        // call emulate button's click in the top toolbar
        function callButtonMethod(buttonName) {
            // find the button by name
            var toolbarButton = getTopToolbarButton(buttonName);
            // test the button and emulate its click
            if (toolbarButton == null || !toolbarButton.callMethod()) {
                alert("'" + buttonName + "' can not be executed.");
            }
            return false;
        }
        // find the button by name in the top toolbar of the Editor
        function getTopToolbarButton(buttonName) {
            var toolbarButton = null;
            // editor client-side object
            var editor = $find("<%= ContentEditor.ClientID %>");
            // top toolbar
            var topToolbar = editor.get_topToolbar();
            // all buttons in the toolbar
            var buttons = topToolbar.get_buttons();
            var buttonsLength = buttons.length;
            // find the button
            for (var i = 0; i < buttonsLength; i++) {
                var button = buttons[i];
                if (button.get_buttonName() == buttonName) { // found
                    toolbarButton = button;
                    break;
                }
            }
            return toolbarButton;
        }
    </script>
</head>
<body style="font:12px Verdana;">
    <span class="tdText"><b>Obout.Ajax.UI.HTMLEditor controls</b> - The Spell Checking will be forced on submit when the checkbox is set. The form will be posted on 'OK' button click
    in the <b>Spell Checker</b> popup</span>
    <br /><br />
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" ID="scriptManager" />
        <input type="checkbox" id="cbForceSpellCheck" runat="server" checked="checked" />&nbsp;<b>Force Spell</b>
        <asp:UpdatePanel ID="updatePanel1" runat="server">
            <ContentTemplate>
               <obout:Editor runat="server" Id="ContentEditor" EditPanel-Height="450px" EditPanel-Width="100%">
                 <TopToolBar Appearance="Lite" PreservePlace="true" >
                    <AddButtons>
                        <obout:HorizontalSeparator runat="server" />
                        <obout:SpellCheck runat="server" />
                    </AddButtons>
                 </TopToolBar>
                 <PopupHolder runat="server">
                    <Preload>
                        <obout:SpellCheckPopup runat="server" ID="spellChecker" />
                    </Preload>
                 </PopupHolder>
               </obout:Editor>
               <br />
               <asp:Button runat="server" Text="Submit content" ID="Submit1" />
               <img alt="" id="wait" align="absMiddle" style="visibility:hidden; height: 30px" src="<%=Page.ClientScript.GetWebResourceUrl(typeof(Obout.Ajax.UI.HTMLEditor.Editor), "Obout.Ajax.UI.HTMLEditor.Images.ed_wait.gif")%>" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
    <br /><br /><a href="Default.aspx?type=CSHARP">< Back to examples</a>
</body>
</html>