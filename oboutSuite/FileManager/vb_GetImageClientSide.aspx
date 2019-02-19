<%@ Page Language="VB" AutoEventWireup="true" CodeFile="vb_GetImageClientSide.aspx.vb" Inherits="FileManager_vb_GetImageClientSide" %>
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

    // called when a file was selected in the gallery
    function filePicked(sender, args) {
        // temporary element
        var element;
        // the result container
        var resultContainer = $get("<%= Result.ClientID %>");
        // clear its content
        resultContainer.innerHTML = "";

        // add title
        resultContainer.appendChild(document.createElement("br"));
        resultContainer.appendChild(document.createElement("br"));
        element = document.createElement("b");
        element.appendChild(document.createTextNode("Selected image:"));
        resultContainer.appendChild(element);
        resultContainer.appendChild(document.createElement("br"));
        resultContainer.appendChild(document.createElement("br"));

        // add the image
        var img = document.createElement("img");
        var size = { width: sender.get_width(), height: sender.get_height() };
        getImageSize(size);
        img.alt = sender.get_tooltip();
        img.title = sender.get_tooltip();
        img.src = sender.get_url();
        img.style.height = size.height + "px";
        img.style.width = size.width + "px";

        resultContainer.appendChild(img);
    }
    function getImageSize(size) {
        var maxwidth = 300;
        var maxheight = 200;
        if (size.width > maxwidth) {
            size.height = (size.height * (maxwidth / size.width));
            size.width = maxwidth;
        }
        if (size.height > maxheight) {
            size.width = (size.width * (maxheight / size.height));
            size.height = maxheight;
        }

        if (size.height == 0) size.height = 5;
        if (size.width == 0) size.width = 5;
        size.height = Math.round(size.height);
        size.width = Math.round(size.width);
    }
</script>
    <span class="tdText"><b>Obout.Ajax.UI.FileManager</b> - Get selected Image using client-side</span>
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
        <obout:FileManager runat="server" ID="fileManager" PopupHolderID="popupHolder" GalleryManagerClassName="Obout.Ajax.UI.HTMLEditor.Popups.ImageBrowser" OnClientFilePicked="filePicked" />
        <asp:Button runat="server" OnClientClick="return openManager();" Text="Open the Image Gallery" />
        <br /><br />
        <asp:Label runat="server" ID="Result" />
   </center>
    </form>
    <br /><br />
    <a href="Default.aspx?type=VBNET">< Back to examples</a>
</body>
</html>
