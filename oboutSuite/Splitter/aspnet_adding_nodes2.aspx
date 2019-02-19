<%@ Register Tagprefix="obspl" Namespace="OboutInc.Splitter2" Assembly="obout_Splitter2_Net" %>
<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.TreeView" TagPrefix="obout" %>
<%@ Page Language="C#" Debug="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script language="C#" runat="server">
	void Page_Load(object sender, EventArgs e) {
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
        else if(NewNodeName.Value.Length > 0)
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
        window.parent.__doPostBack("<%= ObTree.UniqueID %>", JSON.stringify({ type: "ServerSide", NodeIndex: selectedNodeIndex }));
    }
    var selectedNodeIndex = "0";
    function clientOnNodeSelect(sender, args) {
        var obTree = $find("<%=ObTree.ClientID%>");
        selectedNodeIndex = obTree.getNodeIndex(args.node);
    }
</script>

<html>
	<head id="Head1" runat="server">
	    <title>obout ASP.NET Splitter examples</title>
    	   
        <style type="text/css">
            .tdText 
		    {
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
	<body>
	    <form id="Form1" runat="server">
        <asp:ScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />
	    <br />
		<span class="tdText"><b>ASP.NET Splitter - Control left panel from right panel</b></span>
	    <br /><br />
	        <a style="font-size:10pt;font-family:Tahoma" href="Default.aspx?type=ASPNET">« Back to examples</a>
	        <br /><br />
		    <obspl:Splitter StyleFolder="styles/default" id="splDV" runat="server" CookieDays="0">
			    <LeftPanel WidthMin="100" WidthMax="400">
				    <header height="40">
					    <div style="width:100%;height:100%;background-color:#e0e6ed" class="tdText" align="center">
					    <br />
					    optional left header
					    </div>
				    </header>
				    <content>
					    <div style="margin:5px;"> 
                            <asp:UpdatePanel runat="server"><ContentTemplate>
                                <obout:Tree runat="server" RootNodeStyle-NodeCSS="myroot" RootNodeStyle-SubNodeContainerCSS="mycontainer" OnNodeSelect="clientOnNodeSelect" OnSelectedTreeNodeChanged="NodeSelected" AutoPostBackOnNodeSelect="true" ID="ObTree" CssClass="default" />
                                <asp:HiddenField runat="server" ID="NewNodeName" Value="" />
                            </ContentTemplate></asp:UpdatePanel>
					    </div>
				    </content>
				    <footer height="40">
					    <div style="width:100%; height: 100%;background-color:#e0e6ed;" class="tdText" align="center">
					    <br />
					    optional left footer
					    </div>
				    </footer>
			    </LeftPanel>
			    <RightPanel>
			    <header height="50">
					    <div style="width:100%;height:100%;background-color:#ebe9ed" class="tdText" align="center">
					    <br />
					    optional right header
					    </div>
				    </header>
				    <content url="aspnet_adding_nodes2_addpage.aspx">

				    </content>
				    <footer height="50">
					    <div style="width:100%;height:100%;background-color:#ebe9ed" class="tdText" align="center">
					    <br />
					    optional right footer
					    </div>
				    </footer>
			    </RightPanel>
		    </obspl:Splitter>
		 </form>
	</body>
</html>