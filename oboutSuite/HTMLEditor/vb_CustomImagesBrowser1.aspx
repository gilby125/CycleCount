<%@ Page Language="VB" AutoEventWireup="true" CodeFile="vb_CustomImagesBrowser1.aspx.vb" Inherits="HTMLEditor_vb_CustomImagesBrowser1" %>
<%@ Register Assembly="Obout.Ajax.UI" TagPrefix="obout" Namespace="Obout.Ajax.UI.HTMLEditor" %>
<%@ Register Assembly="Obout.Ajax.UI" TagPrefix="obout" Namespace="Obout.Ajax.UI.HTMLEditor.ToolbarButton" %>
<%@ Register Assembly="Obout.Ajax.UI" TagPrefix="obout" Namespace="Obout.Ajax.UI.HTMLEditor.ContextMenu" %>

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
</head>
<body style="font:12px Verdana;">
<script type="text/JavaScript">
</script>
    <span class="tdText"><b>Obout.Ajax.UI.HTMLEditor controls</b> - <b>Image Gallery</b> with custom button in the toolbar</span>
    <br /><br />
    Sometimes it is necessary to add some functionality for the Gallery Manager.
    It can be done by adding custom button(s) to the Manager's toolbar.<br />
    In this example you can see customized <b>"Browse Image Gallery"</b> popup.<br />
    The custom button click just causes an alert with the selected image URL here, but you can modify the client-side functionality as you want.<br />
    To open this popup, click "Browse" button in the "Image properties" popup (insert or edit an Image
    <img style="background-color: blue;margin:0px;" align="absmiddle" alt=""
        src="<%= Page.ClientScript.GetWebResourceUrl(GetType(Obout.Ajax.UI.HTMLEditor.ToolbarButton.CommonButton),"Obout.Ajax.UI.HTMLEditor.Images.ed_image_n.gif") %>" />
    ):
    <br /><br />
    <img alt="" align="absMiddle" src="SiteImages/CustomImageGallery.gif" />
    <br /><br />
    <form id="form1" runat="server">
        <asp:ScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />
        <asp:UpdatePanel ID="updatePanel1" runat="server">
            <ContentTemplate>
                <obout:Editor runat="server" Id="editor" Height="300px" Width="100%">
                    <TopToolbar>
                        <EditPredefinedButtons>
                            <obout:InsertImage RelatedPopupType="CustomPopups.ImagesPropertiesWithCustomBrowser, App_Code" />
                        </EditPredefinedButtons>
                    </TopToolbar>
                    <EditPanel>
                        <ContextMenu>
                            <EditPredefinedItems>
                                <obout:EditImageItem RelatedPopupType="CustomPopups.ImagesPropertiesWithCustomBrowser, App_Code" />
                            </EditPredefinedItems>
                        </ContextMenu>
                    </EditPanel>
                </obout:Editor>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
    <br /><br /><a href="Default.aspx?type=CSHARP">< Back to examples</a>
</body>
</html>