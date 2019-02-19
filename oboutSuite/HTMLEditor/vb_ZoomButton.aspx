<%@ Page Language="VB" AutoEventWireup="true" CodeFile="vb_ZoomButton.aspx.vb" Inherits="HTMLEditor_vb_ZoomButton" %>
<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.HTMLEditor" TagPrefix="obout" %>

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
    <span class="tdText"><b>Obout.Ajax.UI.HTMLEditor controls</b> - Custom select button <b>'Zoom'</b></span>
    <br /><br />
    <form id="form1" runat="server">
        <asp:ScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />

        <asp:UpdatePanel ID="updatePanel1" runat="server">
            <ContentTemplate>
               <obout:Editor runat="server" Id="editor" Height="500px" Width="100%" TopToolbar-Appearance="Lite" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
    <br /><br /><a href="Default.aspx?type=VBNET">< Back to examples</a>
</body>
<script type="text/JavaScript">
    // register namespace
    Type.registerNamespace("CustomToolbarButton");

    // Declare the button's client-side type
    CustomToolbarButton.ZoomButton = function (element) {
        // init
        CustomToolbarButton.ZoomButton.initializeBase(this, [element]);
    }

    // Declare the button's client-side prototype
    CustomToolbarButton.ZoomButton.prototype = {

        // override the base method - just for the 'select' DOM element reset to the default (for FireFox)
        initialize: function () {
            CustomToolbarButton.ZoomButton.callBaseMethod(this, "initialize");
            // 'select' DOM element
            var selectObject = this.get_select();
            selectObject.selectedIndex = 0;
        },

        // override the base method - is called when the option of the 'select' DOM element is changed
        callMethod: function (selectObject) {
            // check the base method
            if (!CustomToolbarButton.ZoomButton.callBaseMethod(this, "callMethod", [selectObject])) return false;

            // designmode panel
            var editor = this.get_designPanel();
            // BODY of the designpanel
            var body = editor.get_doc().body;

            // selected zoom value
            var zoom = selectObject.options.item(selectObject.selectedIndex).value;

            // 'default' selected 
            if (zoom == "") {
                // Firefox doesn't have 'zoom' CSS
                if (Sys.Browser.agent == Sys.Browser.Firefox) {
                    body.style.MozTransform = "";
                } else {
                    body.style.zoom = "";
                }
            } else {
                // some value selected

                // Firefox doesn't support 'zoom' CSS
                if (Sys.Browser.agent == Sys.Browser.Firefox) {
                    body.style.MozTransform = "scale(" + (parseInt(zoom) / 100) + ")";
                } else {
                    body.style.zoom = zoom;
                }
            }
        },

        // we need to override this method just to reset the DOM element to default
        // when switched to Design mode from some other mode
        checkState: function () {
            // check the base method
            if (!CustomToolbarButton.ZoomButton.callBaseMethod(this, "checkState")) return false;

            // designmode panel
            var editor = this.get_designPanel();
            // BODY of the designpanel
            var body = editor.get_doc().body;
            // flag
            var reset = false;

            // Firefox doesn't support 'zoom' CSS
            if (Sys.Browser.agent == Sys.Browser.Firefox) {
                if (body.style.MozTransform.length == 0) {
                    reset = true;
                }
            } else {
                if (body.style.zoom.length == 0) {
                    reset = true;
                }
            }

            if (reset) {
                // 'select' DOM element
                var selectObject = this.get_select();
                selectObject.selectedIndex = 0;
            }

            return true;
        }
    }

    // Register the button's client-side type
    CustomToolbarButton.ZoomButton.registerClass("CustomToolbarButton.ZoomButton", Obout.Ajax.UI.HTMLEditor.ToolbarButton.DesignModeSelectButton);
</script>
</html>