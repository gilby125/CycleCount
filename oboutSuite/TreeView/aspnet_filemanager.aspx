<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="Obout.Ajax.UI.TreeView" %>
<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.TreeView" TagPrefix="obout" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Example Page - Performance</title>
    <script language="C#" runat="server">        
        void Page_load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Node rootNode = new Node()
                {
                    Text = "I am Root node!",
                    Expanded = true,
                    Selected = true,
                    Value = "root?" + Page.MapPath("FileSystemFolder"),
                    ImageUrl = "~/TreeView/icons/xpPanel.gif"
                };
                OboutTree.Nodes.Add(rootNode);
                this.LoadDirectory(Page.MapPath("FileSystemFolder"), rootNode);
            }
            else if (Command.Value.Length > 0)
            {
                string path = "";
                string nodeType = OboutTree.SelectedNode.Value.Split(new char[] { '?' })[0];

                try
                {
                    if (Command.Value == "addfile")
                    {
                        path = getPathFromValue(OboutTree.SelectedNode.Value) + "\\" + NodeName.Value;
                        File.WriteAllText(path, FileText.Value);
                    }
                    else if (Command.Value == "addfolder")
                    {
                        path = getPathFromValue(OboutTree.SelectedNode.Value) + "\\" + NodeName.Value;
                        Directory.CreateDirectory(path);
                    }
                    else if (Command.Value == "deletenode")
                    {
                        path = getPathFromValue(OboutTree.SelectedNode.Value);
                        if (nodeType == "folder")
                        {
                            Directory.Delete(path);
                        } else if(nodeType == "file")
                        {
                            File.Delete(path);
                        }
                    }
                    else if (Command.Value == "renamenode")
                    {
                        path = getPathFromValue(OboutTree.SelectedNode.Value);
                        string newpath = Directory.GetParent(path) + "\\" + NodeName.Value;
                        if (nodeType == "folder")
                        {
                            Directory.Move(path, newpath);
                        }
                        else if (nodeType == "file")
                        {
                            File.Move(path, newpath);
                        }
                    }
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "CreateError", "alert('Create error:\\n\\n" + ex.Message.Replace("\\", "\\\\").Replace("\"", "\\\"").Replace("\n", "\\n").Replace("\r", "").Replace("'", "\\'") + "');", true);
                }
                Command.Value = "";
            }
        }
        private string HierarchicalIndex(Node node)
        {
            //iterate to its top most parent which level is -1
            List<string> list = new List<string>();
            for (Node item = node; item != null && item.Level != -1; item = item.Parent as Node)
            {
                list.Insert(0, item.Parent.ChildNodes.IndexOf(item).ToString());
            }
            //reverse the list.
            return string.Join(":", list.ToArray());
        }
        
        private string getPathFromValue(string value)
        {
            string[] arr = value.Split(new char[] { '?' });
            return String.Join("?", arr, 1, arr.Length - 1);
        }
        private void LoadDirectory(string path, Node parent)
        {
            // clear all in parent
            parent.ChildNodes.Clear();
            
            DirectoryInfo dir = new DirectoryInfo(path);
            foreach (var subDir in dir.GetDirectories())
            {
                Node newNode = new Node()
                {
                    Text = subDir.Name,
                    Value = "folder?"+subDir.FullName,
                    ExpandMode = Obout.Ajax.UI.TreeView.NodeExpandMode.ServerSide,
                    ImageUrl = "img/folder.png"
                };
                parent.ChildNodes.Add(newNode);
                newNode.ClientID = HierarchicalIndex(newNode);
            }
            foreach (var file in dir.GetFiles("*.*"))
            {
                Node newNode = new Node()
                {
                    Text = file.Name,
                    Value = "file?"+file.FullName,
                    ExpandMode = Obout.Ajax.UI.TreeView.NodeExpandMode.ClientSide,
                    ImageUrl = "img/document.png"
                };
                parent.ChildNodes.Add(newNode);
                newNode.ClientID = HierarchicalIndex(newNode);
            }
        }

        protected void OboutTree1_TreeNodeExpanded(object sender, Obout.Ajax.UI.TreeView.NodeEventArgs e)
        {
            Node node = e.Node;
            string nodeType = node.Value.Split(new char[] { '?' })[0];
            string path = getPathFromValue(node.Value);
            if (nodeType == "file")
            {
                if (!File.Exists(path))
                {
                    node = node.Parent;
                    path = getPathFromValue(node.Value);
                    node.Selected = true;
                }
            }
            else if (nodeType == "folder")
            {
                if (!Directory.Exists(path))
                {
                    node = node.Parent;
                    path = getPathFromValue(node.Value);
                    node.Selected = true;
                }
            }
            nodeType = node.Value.Split(new char[] { '?' })[0];

            if (nodeType == "folder" || nodeType == "root")
            {
                this.LoadDirectory(path, node);
            }
        }

        void NodeSelected(object sender, NodeEventArgs e)
        {
        }
    </script>
    <style type="text/css">
        body
        {
            font-family: "Segoe UI" ,Arial,sans-serif;
            font-size: 12px;
        }
		.tdText {
			font:11px Verdana;
			color:#333333;
		}
        .myroot .ic
        {
	        display: none !important;
	        height: 0px !important;
	        width: 0px !important;
        }
        .myroot
        {
	        background: none !important;
	        padding-left: 0px !important;
        }
        .mycontainer
        {
	        padding-left: 0px !important;
	        margin-left: -2px !important;
        }
    </style>
</head>
<script type="text/javascript">
    function ExecuteCommand() {
        var nodeName = $get("nodeName").value;
        if (commandType != "deletenode" && !nodeName.match(/^[a-zA-Z1-9_-]+[\.]*[a-zA-Z]*$/)) {
            $get("nodeName").focus();
            alert("Folder/File name should be specified correctly");
            return false;
        }
        $get("<%= NodeName.ClientID %>").value = nodeName;
        $get("<%= Command.ClientID %>").value = commandType;
        if (commandType == "addfile") {
            $get("<%= FileText.ClientID %>").value = $get("fileText").value;
        }
        window.parent.__doPostBack("<%= OboutTree.UniqueID %>", JSON.stringify({ type: "ServerSide", NodeIndex: selectedNodeIndex }));
        return false;
    }

    var selectedNodeIndex = "0";
    function clientOnNodeSelect(sender, args) {
        //selectedNodeIndex = sender.getNodeIndex(args.node);
    }

    var commandType = "addfile";
    function changeAddType(obj) {
        if (obj.checked) {
            if (obj.value != "null") {
                commandType = obj.value;
                $get("secondRow").style.display = (commandType == "addfile") ? "" : "none";
                $get("firstRow").style.display = (commandType == "deletenode") ? "none" : "";
            }
        }
    }

    function pageLoad(sender, args) {
        var tree = $find("<%= OboutTree.ClientID %>");
        selectedNodeIndex = tree.getNodeIndex(tree.getSelectedNodes()[0]);
        var nodeValue = tree.getNodeValue(tree.getNodeByIndex(selectedNodeIndex));
        var nodeType = nodeValue.split("?")[0];
        if (nodeType == "root") {
            $get("manPart").style.display = "none";
            $get("addPart").style.display = "";
            if (!$get("folderRadio").checked) {
                $get("fileRadio").checked = true;
            }
        } else if (nodeType == "file") {
            $get("manPart").style.display = "";
            $get("addPart").style.display = "none";
            if (!$get("deleteRadio").checked) {
                $get("renameRadio").checked = true;
            }
        } else {
            $get("manPart").style.display = "";
            $get("addPart").style.display = "";
        }
        commandType = getCommandType();
        $get("secondRow").style.display = (commandType == "addfile") ? "" : "none";
        $get("firstRow").style.display = (commandType == "deletenode") ? "none" : "";
    }
    function getCommandType() {
        var radios = document.getElementsByName("commandType");
        var retval = "";
        for (var i = 0; i < radios.length; i++) {
            var item = radios[i];
            if (item.checked) {
                retval = item.value;
                break;
            }
        }
        return retval;
    }
</script>
<body>
    <form id="form1" runat="server">
    <br />
    <a class="examples" href="Default.aspx?type=ASPNET">« Back to examples</a>
    <br />
    <asp:ScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />
    <h2>
        ASP.NET TreeView - File Manager Sample</h2>
    <table>
        <tr>
            <td align="left" valign="top" class="tdText">
                <asp:UpdatePanel runat="server"><ContentTemplate>
                    <obout:Tree ID="OboutTree" runat="server" CssClass="default" RootNodeStyle-NodeCSS="myroot" RootNodeStyle-SubNodeContainerCSS="mycontainer"
                        OnNodeSelect="clientOnNodeSelect" OnSelectedTreeNodeChanged="NodeSelected" AutoPostBackOnNodeSelect="true"
                        OnTreeNodeExpanded="OboutTree1_TreeNodeExpanded" Width="300px">
                    </obout:Tree>
                    <asp:HiddenField runat="server" ID="NodeName" Value="" />
                    <asp:HiddenField runat="server" ID="FileText" Value="" />
                    <asp:HiddenField runat="server" ID="Command" Value="" />
                </ContentTemplate></asp:UpdatePanel>
            </td>
            <td align="left" valign="top" class="tdText">
                    Choose a command on the selected node:<br /><br />
                    <div id="addPart">
			            <input id="folderRadio" type="radio" name="commandType" value="addfolder" onclick="changeAddType(this)" />Add new folder<br />
			            <input id="fileRadio" type="radio" name="commandType" value="addfile" onclick="changeAddType(this)" checked="checked"/>Add new file<br />
                    </div>
                    <div id="manPart" style="display:none">
			            <input id="deleteRadio" type="radio" name="commandType" value="deletenode" onclick="changeAddType(this)"/>Delete selected node<br />
			            <input id="renameRadio" type="radio" name="commandType" value="renamenode" onclick="changeAddType(this)""/>Rename selected node<br />
                    </div>
                    <br />
                    <table>
                        <tr id="firstRow">
                            <td class="tdText">
                                Folder/File name:
                            </td>
                            <td>
                                <input type="text" id="nodeName" value="newNode" class="tdtext" style="width:200px"/>
                            </td>
                        </tr>
                        <tr id="secondRow">
                            <td class="tdText">
                                Text in file:
                            </td>
                            <td>
                                <textarea id="fileText" rows="5" cols="40" class="tdText" style="width:200px"></textarea>
                            </td>
                        </tr>
                    </table>
                    <input type="button" value="Execute command" id="executeCommand" onclick="return ExecuteCommand();" class="tdText" />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
