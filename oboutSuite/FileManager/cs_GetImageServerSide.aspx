<%@ Page Language="C#" AutoEventWireup="true" CodeFile="cs_GetImageServerSide.aspx.cs" Inherits="FileManager_cs_GetImageServerSide" %>
<%@ Register TagPrefix="obout" Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.FileManager" %>
<%@ Register TagPrefix="obout" Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.HTMLEditor" %>
<%@ Register TagPrefix="obout" Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.HTMLEditor.Popups" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>FileManager Sample</title>
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
<body>
<script type="text/javascript">
    function openManager() {
        $find('<%= fileManager.ClientID %>').openManager();
        return false;
    }
    function pageLoad(sender, e) {
        function invokingRequest() {
            Sys.Net.WebRequestManager.remove_invokingRequest(invokingRequest);
            $get("<%= openManagerButton.ClientID %>").disabled = true;
            $get("wait").style.visibility = "visible";
        }
        Sys.Net.WebRequestManager.add_invokingRequest(invokingRequest);
        var wait = $get("wait");
        wait.style.visibility = "hidden";
        wait.style.height = document.getElementById("<%= openManagerButton.ClientID %>").offsetHeight + "px";
    }
</script>
    <span class="tdText"><b>Obout.Ajax.UI.FileManager</b> - Get selected Image using server-side</span>
    <br /><br />
    <form id="form1" runat="server">
    <asp:ScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />

    <%-- PopupHolder used by the FileManager --%>
    <obout:PopupHolder runat="server" ID="popupHolder" DefaultAddPolicy="Demand">
        <Demand>  
            <obout:ImageBrowser runat="server" ShowPreviewPanel="true">
                <%-- Set the Tree features --%>
                <TreeFeatures FolderImageUrl="~/treeview/icons/folder_old.gif" > <%-- folders --%>
                    <LeafImages>
                        <%-- For images with any extensions --%>
                        <obout:LeafImage Extensions="*" Url="~/treeview/img/picture.png" />
                    </LeafImages>
                </TreeFeatures>
            </obout:ImageBrowser>
        </Demand>
    </obout:PopupHolder>
    <center>
        Click the button to pick an Image
        <br /><br />
        <asp:UpdatePanel runat="server" ID="UpdatePanel1">
            <ContentTemplate>
                <obout:FileManager runat="server" ID="fileManager" PopupHolderID="popupHolder" GalleryManagerClassName="Obout.Ajax.UI.HTMLEditor.Popups.ImageBrowser" RetainPopupPosition="false" OnPostBack="fileselected_postback" AutoPostBack="true" />
                <asp:Button runat="server" ID="openManagerButton" OnClientClick="return openManager();" Text="Open the Image Gallery" />
                <img alt="" id="wait" align="absMiddle" style="visibility:hidden; height: 30px" src="<%=Page.ClientScript.GetWebResourceUrl(typeof(Obout.Ajax.UI.HTMLEditor.Editor), "Obout.Ajax.UI.HTMLEditor.Images.ed_wait.gif")%>" />
                <br /><br />
                <asp:Label runat="server" ID="Result" />
            </ContentTemplate>
        </asp:UpdatePanel>
   </center>
    </form>
    <br /><br />
    <a href="Default.aspx?type=CSHARP">< Back to examples</a>
</body>
</html>
