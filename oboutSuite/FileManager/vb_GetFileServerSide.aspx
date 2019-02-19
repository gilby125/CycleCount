<%@ Page Language="VB" AutoEventWireup="true" CodeFile="vb_GetFileServerSide.aspx.vb" Inherits="FileManager_vb_GetFileServerSide" %>
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
    <span class="tdText"><b>Obout.Ajax.UI.FileManager</b> - Get information of the selected file using server-side</span>
    <br /><br />
    <form id="form1" runat="server">
    <asp:ScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />

    <%-- PopupHolder used by the FileManager --%>
    <obout:PopupHolder runat="server" ID="popupHolder" DefaultAddPolicy="Demand">
        <Demand>  
                <%-- Use the obout TreeView control in 'FileBrowser' popup --%>
                <obout:FileBrowser runat="server" UseOboutTree="true" ShowPreviewPanel="true">
                  <%-- Set different previewers for different files extensions --%>
                   <Previews>
                        <%-- All Images here --%>
                         <obout:Preview Extensions="jpg;jpeg;gif;bmp;png"
                                                 TypeName="Obout.Ajax.UI.HTMLEditor.Popups.ImageBrowser" />
                         <%-- Flash Video --%>
                         <obout:Preview Extensions="flv" TypeName="Obout.Ajax.UI.HTMLEditor.Popups.FlashVideoBrowser" />
                         <%-- Flash files --%>
                          <obout:Preview Extensions="swf" TypeName="Obout.Ajax.UI.HTMLEditor.Popups.FlashBrowser" />
                         <%-- Media --%>
                          <obout:Preview Extensions="mpeg;avi" TypeName="Obout.Ajax.UI.HTMLEditor.Popups.MediaBrowser" />
                          <%-- All other files - just show description of the file (if exists) --%>
                          <obout:Preview Extensions="*" TypeName="Obout.Ajax.UI.HTMLEditor.Popups.UrlBrowser" />
                   </Previews>
                  <%-- Set the Tree features --%>
                   <TreeFeatures FolderImageUrl="~/treeview/icons/folder_old.gif" > <%-- folders --%>
                          <%-- Set different leaf images for different files extensions --%>
                          <LeafImages>
                               <obout:LeafImage Extensions="html" Url="~/treeview/icons/ie_link.gif" />
                               <obout:LeafImage Extensions="doc;docx" Url="~/treeview/icons/doc.gif" />
                               <obout:LeafImage Extensions="txt" Url="~/treeview/img/vista_note.png" />
                               <obout:LeafImage Extensions="jpg;jpeg;gif;bmp;png" Url="~/treeview/img/picture.png" />
                               <obout:LeafImage Extensions="mp4;avi;mpeg;flv" Url="~/treeview/img/video.png" />
                               <obout:LeafImage Extensions="mp3;wav" Url="~/treeview/img/music.png" />
                               <obout:LeafImage Extensions="*" Url="~/treeview/icons/square_yellowS.gif" />
                          </LeafImages>
                   </TreeFeatures>
               </obout:FileBrowser>
        </Demand>
     </obout:PopupHolder>
    <center>
        Click the button to pick a file
        <br /><br />
        <asp:UpdatePanel runat="server" ID="UpdatePanel1">
            <ContentTemplate>
                <obout:FileManager runat="server" ID="fileManager" PopupHolderID="popupHolder" RetainPopupPosition="false" OnPostBack="fileselected_postback" AutoPostBack="true" />
                <asp:Button runat="server" ID="openManagerButton" OnClientClick="return openManager();" Text="Open File Manager" />
                <img alt="" id="wait" align="absMiddle" style="visibility:hidden; height: 30px" src="<%=Page.ClientScript.GetWebResourceUrl(GetType(Obout.Ajax.UI.HTMLEditor.Editor), "Obout.Ajax.UI.HTMLEditor.Images.ed_wait.gif")%>" />
                <br /><br />
                <asp:Label runat="server" ID="Result" />
            </ContentTemplate>
        </asp:UpdatePanel>
   </center>
    </form>
    <br /><br />
    <a href="Default.aspx?type=VBNET">< Back to examples</a>
</body>
</html>
