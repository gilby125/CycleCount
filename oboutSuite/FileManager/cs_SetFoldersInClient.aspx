<%@ Page Language="C#" AutoEventWireup="true" CodeFile="cs_SetFoldersInClient.aspx.cs" Inherits="FileManager_cs_SetFoldersInClient" %>
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
    // open the File Manager
    function openManager() {
        $find('<%= fileManager.ClientID %>').openManager();
        return false;
    }
    // On dropdown list changed
    function onUserChange(sender, index) {
        $get("<%= UserName.ClientID %>").value = sender.options[index].text;
    }
    // before the Image Browser be opened
    function beforePopupShown(sender, args) {
        // set the Gallery Folders
        sender.set_galleryFolders("Images/" + $get("<%= UserName.ClientID %>").value);
        // set the Managed Folders
        sender.set_managedFolders("Images/" + $get("<%= UserName.ClientID %>").value);
        // set the Gallery Names
        sender.set_galleryNames($get("<%= UserName.ClientID %>").value);
        // disable the dropdown list
        ddl1.disable();
    }
    // on the Image Browser be closed
    function popupHidden(sender, args) {
        // enable the dropdown list
        ddl1.enable();
    }
    // on page load
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
    <span class="tdText"><b>Obout.Ajax.UI.FileManager</b> - Set Images' folders in client-side</span>
    <br /><br />
    <form id="form1" runat="server">
    <asp:ScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />

    <%-- PopupHolder used by the FileManager --%>
    <obout:PopupHolder runat="server" ID="popupHolder" DefaultAddPolicy="Demand">
        <Demand>  
            <%-- Use the obout TreeView control in 'ImageBrowser' popup --%>
            <obout:ImageBrowser runat="server" UseOboutTree="true" ShowPreviewPanel="true" OnClientBeforeShown="beforePopupShown" OnClientHidden="popupHidden">
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
        Select subfolder in 'Images' folder:
		<obout:OboutDropDownList runat="server" ID="ddl1" Width="200" Height="60" FolderStyle="../Interface/styles/grand_gray/OboutDropDownList" >
		    <ClientSideEvents OnSelectedIndexChanged="onUserChange" />
		    <Items>
		        <asp:ListItem>User_1</asp:ListItem>
		        <asp:ListItem>User_2</asp:ListItem>
		        <asp:ListItem>User_3</asp:ListItem>
		    </Items>		    
		</obout:OboutDropDownList><br /><br />
        Click the button to pick an Image
        <br /><br />
        <asp:UpdatePanel runat="server" ID="UpdatePanel1">
            <ContentTemplate>
                <obout:FileManager runat="server" ID="fileManager" PopupHolderID="popupHolder" GalleryManagerClassName="Obout.Ajax.UI.HTMLEditor.Popups.ImageBrowser" RetainPopupPosition="false" OnPostBack="fileselected_postback" AutoPostBack="true" />
                <asp:HiddenField runat="server" ID="UserName" Value="User_1" />
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
