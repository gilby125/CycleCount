<%@ Page Language="VB" AutoEventWireup="true" CodeFile="vb_InsertImageFromGallery.aspx.vb" Inherits="HTMLEditor_vb_InsertImageFromGallery" %>
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
    <span class="tdText"><b>Obout.Ajax.UI.HTMLEditor controls</b> - Custom button <b>'Insert image from the Gallery'</b> <img alt="" src="../App_Obout/HTMLEditor/customButtons/ed_upload_image_n.gif" align="absmiddle" style="background-color:Blue;" /></span>
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

    CustomToolbarButton.ImageInsert = function (element) {
        // init
        CustomToolbarButton.ImageInsert.initializeBase(this, [element]);
        // delegate to be called on 'OK' in the popup
        this._relatedPopupClosedOnOk$delegate = Function.createDelegate(this, this._relatedPopupClosedOnOk);
    }

    CustomToolbarButton.ImageInsert.prototype = {
        // override method called on button mousedown
        callMethod: function () {
            // if popup is loaded already then set the callback delegate to be called on 'OK' in the popup
            if (this._relatedPopup) {
                this._relatedPopup.okCallback = this._relatedPopupClosedOnOk$delegate;
            }
            // call the base method
            return CustomToolbarButton.ImageInsert.callBaseMethod(this, "callMethod");
        },

        // method called on 'OK' in the popup
        _relatedPopupClosedOnOk: function (contentWindow, result) {
            // get all properties of the selected image
            var url = "", height = "", width = "", tooltip = "";
            for (var i = 0; i < result.length; i++) {
                if (result[i].name == "url") {
                    url = result[i].value;
                } else if (result[i].name == "height") {
                    height = result[i].value;
                } if (result[i].name == "width") {
                    width = result[i].value;
                } if (result[i].name == "tooltip") {
                    tooltip = result[i].value;
                }
            }
            // insert a new image
            this._insertMarkup(url, width, height, tooltip);
        },

        // insert a new image
        _insertMarkup: function (url, width, height, tooltip) {
            // save content for 'undo'
            this.get_designPanel()._saveContent();
            // insert the HTML markup to the current cursor position
            this.get_designPanel().insertHTML("<img src=\"" + url + "\" height=\"" + height + "\" width=\"" + width + "\" title=\"" + tooltip + "\" alt=\"" + tooltip + "\">");
            // update status of toolbar's buttons ('undo', 'redo')
            this.get_editPanel().updateToolbar();
        }
    }

    // Register this class
    CustomToolbarButton.ImageInsert.registerClass("CustomToolbarButton.ImageInsert", Obout.Ajax.UI.HTMLEditor.ToolbarButton.OpenPopupButton);
</script>
</html>