<%@ Page Language="C#" Debug="true" %>
<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.TreeView" TagPrefix="obout" %>
<script language="C#" runat="server">
    void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            Node rootNode;
            Node newNode;

            rootNode = new Node()
            {
                Text = "<span style='cursor:pointer'>I am Root node!</span>",
                Expanded = true,
                Selected = true,
                ImageUrl = "~/TreeView/icons/xpPanel.gif"
            };
            ObTree.Nodes.Add(rootNode);

            newNode = new Node()
            {
                Text = "<span style='cursor:pointer;'>Obout Inc</span>",
                Expanded = true,
                Selected = true,
                ImageUrl = "~/TreeView/img/folder.png"
            };
            rootNode.ChildNodes.Add(newNode);

            newNode = new Node()
            {
                Text = "<span style='cursor:pointer;'>Brooklyn Bridge</span>",
                Expanded = true,
                ImageUrl = "~/TreeView/img/folder.png"
            };
            rootNode.ChildNodes.Add(newNode);

            newNode.ChildNodes.Add(new Node()
            {
                Text = "<span style='cursor:pointer;'>Drawing</span>",
                ImageUrl = "~/TreeView/img/folder.png"
            });

            newNode.ChildNodes.Add(new Node()
            {
                Text = "<span style='cursor:pointer;'>Picture</span>",
                ImageUrl = "~/TreeView/img/folder.png"
            });

            newNode = new Node()
            {
                Text = "<span style='cursor:pointer;'>Picture</span>",
                Expanded = true,
                ImageUrl = "~/TreeView/img/folder.png"
            };
            rootNode.ChildNodes.Add(newNode);

            newNode.ChildNodes.Add(new Node()
            {
                Text = "<span style='cursor:pointer;'>Obout Inc</span>",
                ImageUrl = "~/TreeView/img/folder.png"
            });

            newNode.ChildNodes.Add(new Node()
            {
                Text = "<span style='cursor:pointer;'>My Pictures</span>",
                ImageUrl = "~/TreeView/img/folder.png"
            });
        }
        else if (NewNodeName.Value.Length > 0)
        {
            // add a new node
            ObTree.SelectedNode.ChildNodes.Add(new Node()
            {
                Text = NewNodeName.Value,
                ImageUrl = "~/TreeView/icons/ball_blueS.gif"
            });
            Node parent = ObTree.SelectedNode.Parent;
            while (parent != null)
            {
                parent.Expanded = true;
                parent = parent.Parent;
            }
            NewNodeName.Value = "";
        }
    }
    void NodeSelected(object sender, NodeEventArgs e)
    {
    }
</script>
<script type="text/javascript">
    function AddNode(nodeName) {
        $get("<%= NewNodeName.ClientID %>").value = nodeName;
        __doPostBack("<%= ObTree.UniqueID %>", JSON.stringify({ type: "ServerSide", NodeIndex: selectedNodeIndex }));
    }
    var selectedNodeIndex = "0";
    function clientOnNodeSelect(sender, args) {
        var obTree = $find("<%=ObTree.ClientID%>");
        selectedNodeIndex = obTree.getNodeIndex(args.node);
    }
</script>
<html>
	<head runat="server">
        <title></title>
        <style type="text/css">
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
	<body>
	    <form id="Form1" runat="server">
        <asp:ScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />
		<div style="margin:5px;font:11px verdana;"> 
			<span style="color:crimson">In this splitter panel is loaded another page.</span>
			<br /><br />
            <asp:UpdatePanel runat="server"><ContentTemplate>
                <obout:Tree runat="server" RootNodeStyle-NodeCSS="myroot" RootNodeStyle-SubNodeContainerCSS="mycontainer" OnNodeSelect="clientOnNodeSelect" OnSelectedTreeNodeChanged="NodeSelected" AutoPostBackOnNodeSelect="true" ID="ObTree" CssClass="default" />
                <asp:HiddenField runat="server" ID="NewNodeName" Value="" />
            </ContentTemplate></asp:UpdatePanel>
		</div>
        </form>
	</body>
</html>

