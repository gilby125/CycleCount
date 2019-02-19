<%@ Page Language="VB" AutoEventWireup="true" CodeFile="vb_GetFileClientSide.aspx.vb" Inherits="FileManager_vb_GetFileClientSide" %>
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
        element = document.createElement("b");
        element.appendChild(document.createTextNode("Parameters of the selected file"));
        resultContainer.appendChild(element);
        resultContainer.appendChild(document.createElement("br"));

        // add the table with parameters
        var table = document.createElement("table");
        table.cellSpacing = "3";
        table.style.borderWidth = "1px";
        table.style.borderColor = "gray";
        table.style.borderStyle = "solid";
        resultContainer.appendChild(table);
        addRow(table.insertRow(table.rows.length), "Url", sender.get_url(), "lightgray");
        addRow(table.insertRow(table.rows.length), "Title", sender.get_tooltip(), "white");
        addRow(table.insertRow(table.rows.length), "Width", sender.get_width(), "lightgray");
        addRow(table.insertRow(table.rows.length), "Height", sender.get_height(), "white");
        addRow(table.insertRow(table.rows.length), "Info", sender.get_info(), "lightgray");
    }
    function addRow(tr, name, value, background) {
        // temporary element
        var element;
        tr.style.backgroundColor = background;
        // add cell for the name
        var td = tr.insertCell(tr.cells.length);
        td.align = "left";
        element = document.createElement("b");
        element.appendChild(document.createTextNode(name));
        td.appendChild(element);
        td.appendChild(document.createTextNode(":"));
        // add cell for the value
        td = tr.insertCell(tr.cells.length);
        td.align = "left";
        td.appendChild(document.createTextNode(value));
    }
</script>
    <span class="tdText"><b>Obout.Ajax.UI.FileManager</b> - Get information of the selected file using client-side</span>
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
        <obout:FileManager runat="server" ID="fileManager" PopupHolderID="popupHolder" OnClientFilePicked="filePicked" />
        <asp:Button runat="server" OnClientClick="return openManager();" Text="Open File Manager" />
        <br /><br />
        <asp:Label runat="server" ID="Result" />
   </center>
    </form>
    <br /><br />
    <a href="Default.aspx?type=VBNET">< Back to examples</a>
</body>
</html>
