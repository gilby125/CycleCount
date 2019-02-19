<%@ Page Language="VB" ASPCOMPAT="TRUE"%>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.TreeView" TagPrefix="obout" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script language="VB" runat="server">
    Private Sub Page_load(sender As Object, e As EventArgs)
        If Not Page.IsPostBack Then
            Dim rootNode As New Node() With { _
             .Expanded = True, _
             .Text = "Working time", _
             .ClientID = "root", _
             .ImageUrl = "../treeview/icons/xpMyComp.gif" _
            }
            ObTree.Nodes.Add(rootNode)

            ' Populate Treeview.
            Dim a_0 As New Node() With { _
             .Expanded = True, _
             .Text = "Albert Yap", _
             .ClientID = "a_0", _
             .ImageUrl = "../treeview/icons/folder.gif" _
            }
            rootNode.ChildNodes.Add(a_0)
            a_0.ChildNodes.Add(New Node() With { _
             .Text = "1st half of March", _
             .ClientID = "a_1", _
             .ImageUrl = "../treeview/icons/page.gif" _
            })
            a_0.ChildNodes.Add(New Node() With { _
             .Text = "2nd half of March", _
             .ClientID = "a_2", _
             .ImageUrl = "../treeview/icons/page.gif" _
            })
            a_0.ChildNodes.Add(New Node() With { _
             .Text = "1st half of April", _
             .ClientID = "a_3", _
             .ImageUrl = "../treeview/icons/page.gif" _
            })
            a_0.ChildNodes.Add(New Node() With { _
             .Text = "2st half of March", _
             .ClientID = "a_4", _
             .ImageUrl = "../treeview/icons/page.gif" _
            })

            Dim a_5 As New Node() With { _
             .Expanded = True, _
             .Text = "Mike Baker", _
             .ClientID = "a_5", _
             .ImageUrl = "../treeview/icons/folder.gif" _
            }
            rootNode.ChildNodes.Add(a_5)
            a_5.ChildNodes.Add(New Node() With { _
             .Text = "1st half of March", _
             .ClientID = "a_6", _
             .ImageUrl = "../treeview/icons/page.gif" _
            })
            a_5.ChildNodes.Add(New Node() With { _
             .Text = "2nd half of March", _
             .ClientID = "a_7", _
             .ImageUrl = "../treeview/icons/page.gif", _
             .Selected = True _
            })
            a_5.ChildNodes.Add(New Node() With { _
             .Text = "1st half of April", _
             .ClientID = "a_8", _
             .ImageUrl = "../treeview/icons/page.gif" _
            })
            a_5.ChildNodes.Add(New Node() With { _
             .Text = "2st half of March", _
             .ClientID = "a_9", _
             .ImageUrl = "../treeview/icons/page.gif" _
            })

            CreateGrid()
        End If
    End Sub

    Private Sub CreateGrid()
        Dim myConn As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("../App_Data/timesheet.mdb"))

        Dim myComm As New OleDbCommand("SELECT *, (Sun + Mon + Tue + Wed + Thu + Fri + Sat) AS Total,(Sun2 + Mon2 + Tue2 + Wed2 + Thu2 + Fri2 + Sat2) AS Total2 FROM March WHERE ID < 11 ORDER BY ID ASC", myConn)
        myConn.Open()
        Dim myReader As OleDbDataReader = myComm.ExecuteReader()

        grid1.DataSource = myReader
        grid1.DataBind()

        myConn.Close()
    End Sub
</script>		

<html>
	<head runat="server">
		<title>obout ASP.NET Grid examples</title>
		<style type="text/css">
			.tdText {
				font:11px Verdana;
				color:#333333;
			}
			.option2{
				font:11px Verdana;
				color:#0033cc;
				background-color___:#f6f9fc;
				padding-left:4px;
				padding-right:4px;
			}
			a {
				font:11px Verdana;
				color:#315686;
				text-decoration:underline;
			}
			a:hover {
				color:crimson;
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
			    function imgClick(img, value) {
			        try {
			            if (img.src.indexOf("plusik_r.gif") < 0) {
			                img.src = "../TreeView/icons/plusik_r.gif";

			                var td = img.parentNode.nextSibling;
			                td.style.display = "none";

			                if (value == 1) {
			                    grid1.hideColumn("Mon");
			                    grid1.hideColumn("Tue");
			                    grid1.hideColumn("Wed");
			                    grid1.hideColumn("Thu");
			                    grid1.hideColumn("Fri");
			                } else {
			                    grid1.hideColumn("Mon2");
			                    grid1.hideColumn("Tue2");
			                    grid1.hideColumn("Wed2");
			                    grid1.hideColumn("Thu2");
			                    grid1.hideColumn("Fri2");
			                }
			            } else {
			                img.src = "../TreeView/icons/minus_r.gif";

			                var td = img.parentNode.nextSibling;
			                td.style.display = "";

			                if (value == 1) {
			                    grid1.showColumn("Mon");
			                    grid1.showColumn("Tue");
			                    grid1.showColumn("Wed");
			                    grid1.showColumn("Thu");
			                    grid1.showColumn("Fri");
			                } else {
			                    grid1.showColumn("Mon2");
			                    grid1.showColumn("Tue2");
			                    grid1.showColumn("Wed2");
			                    grid1.showColumn("Thu2");
			                    grid1.showColumn("Fri2");
			                }

			            }
			        } catch (ex) {
			        }
			    }

			    function onRecordSelect(arrSelectedRecords) {
			        var tree = $find("<%=ObTree.ClientID %>");
			        if (tree == null) {
			            setTimeout(function () { onRecordSelect(arrSelectedRecords); }, 10);
                        return
			        }
			        var sMessage;
			        var node_id;

			        if (0 < grid1.SelectedRecords.length) {
			            var id = grid1.SelectedRecords[0].ID;

			            node_id = "a_" + (id - 1);
			        }

			        var tree_selected_id = tree.getSelectedNodes()[0].id;

			        if (tree_selected_id == node_id || node_id == null || node_id == "root_tree1") {
			            return;
			        }
			        var node = document.getElementById(node_id);
			        //node.onclick();
			        if(node != null) tree.setSelected(node);

			    }

			    function onDblClick(id) {
			        var tree = $find("<%=ObTree.ClientID %>");
			        var node_id;

			        if (0 < grid1.SelectedRecords.length) {
			            var id = grid1.SelectedRecords[0].ID;

			            node_id = "a_" + (id - 1);
			        }
			        if (node_id == null || node_id == "root") {
			            return;
			        }
			        // try to expand
			        var node = tree.getNode(node_id);
			        if (tree.hasChildNode(node)) {
			            tree.expand(node);
			        }


			    }
	</script>
	<body style="margin: 0px;">	
		<form runat="server">
        <asp:ScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />
		<br />
		<span class="tdText"><b>ASP.NET Grid - Using withTreeView</b></span>
		<br /><br />
		<span class="tdtext">When a node is collapsed/expanded (and all its children are hidden) <br>
		the corresponding rows from the Grid are hidden/shown.<br><br>
		When the -/+ buttons on the left of the Weeks are clicked,<br> the groups of columns are hidden/shown.<br><br>
		When the row on the grid is double clicked,<br> the corresponding node is collapsed/expanded.
</span><br/><br/>

<table>
	<tr>
	<td valign="top">
		<div style="padding-top: 35px;">
            <obout:Tree ID="ObTree" runat="server" OnNodeSelect="clientNodeSelect" OnNodeExpand="onNodeExpand" OnNodeCollapse="onNodeCollapse" Width="200px" RootNodeStyle-NodeCSS="myroot" RootNodeStyle-SubNodeContainerCSS="mycontainer">
            </obout:Tree>
		</div>
	</td>
	<td valign="top">
		<table>
			<tr>
				<td class="tdText"><img alt="" src="../TreeView/icons/minus_r.gif" onclick="imgClick(this, 1);" style="cursor:pointer;" width="19" height="16"/></td><td class="tdText"  width="230" valign="middle">Week 1</td>
				<td class="tdText"><img alt="" src="../TreeView/icons/minus_r.gif" onclick="imgClick(this, 2);" style="cursor:pointer;" width="19" height="16"/></td><td class="tdText" valign="middle">Week 2</td>
			</tr>
		</table>
		<span class="tdText">
		
		
		</span>
		<obout:Grid id="grid1" runat="server" CallbackMode="true" Serialize="true"  GenerateRecordIds="true" FolderStyle="styles/grand_gray" AutoGenerateColumns="false" AllowAddingRecords="false"  AllowPaging="false" AllowPageSizeSelection="false" AllowSorting="false" PageSize="21">
			<ClientSideEvents onClientSelect="onRecordSelect" OnClientDblClick="onDblClick"/>
			<Columns>
				<obout:Column DataField="ID" ReadOnly="true" Visible="false" HeaderText="ID" runat="server"/>
				<obout:Column DataField="Mon" ReadOnly="true" HeaderText="Mon" Width="50" runat="server"/>
				<obout:Column DataField="Tue" ReadOnly="true" HeaderText="Tue" Width="50" runat="server"/>
				<obout:Column DataField="Wed" ReadOnly="true" HeaderText="Wed" Width="50" runat="server"/>
				<obout:Column DataField="Thu" ReadOnly="true" HeaderText="Thu" Width="50" runat="server"/>
				<obout:Column DataField="Fri" ReadOnly="true" HeaderText="Fri" Width="50" runat="server"/>

				<obout:Column DataField="Mon2" ReadOnly="true" HeaderText="Mon" Width="50" runat="server"/>
				<obout:Column DataField="Tue2" ReadOnly="true" HeaderText="Tue" Width="50" runat="server"/>
				<obout:Column DataField="Wed2" ReadOnly="true" HeaderText="Wed" Width="50" runat="server"/>
				<obout:Column DataField="Thu2" ReadOnly="true" HeaderText="Thu" Width="50" runat="server"/>
				<obout:Column DataField="Fri2" ReadOnly="true" HeaderText="Fri" Width="50" runat="server"/>
			</Columns>
		</obout:Grid>				
	</td>
</tr>
</table>
		<br /><br /><br />
		<a href="Default.aspx?type=VBNET">« Back to examples</a>
		
		</form>
	</body>
</html>
		<script type="text/javascript">
		grid1.selectRecord(7);
		
		var rowPrefix;

		// find out the row Prefix 
		function getRowPrefix() {
			var row0 = grid1.getRecordsIds().split(",")[0];
			
			if ( row0 != null)
			{
				var lastPos = -1;
				for ( var i = row0.length-1; i>=0; i--)
				{
					if ( row0.charAt(i)== '_' )
					{
						lastPos = i;
						break;
					}
				}

				if (lastPos > -1)
				{
					// get Prefix
					return row0.substring(0,lastPos + 1);
				}
			}
			return "";
		}

		hideRow();
	

		function hideRow(){
			if ( rowPrefix == null)
			{
				rowPrefix = getRowPrefix();
			}
        }

		function onNodeCollapse(sender, args) {
		    var id = args.node.id;
		    if (id == "root") return;
		    var display = "none";

		    // find out the start and end position of all hide records of child nodes
		    var startHideRow = parseInt(id.replace("a_", ""));
		    var endHideRow = parseInt(getChildWithMaxIndex(sender, document.getElementById(id)).id.replace("a_", ""));

		    // hide all records of child nodes.
		    for (var i = startHideRow + 1; i <= endHideRow; i++) {
		        document.getElementById(rowPrefix + i).style.display = display;
		    }
		    if (true) {
		    }
		}

		function getChildWithMaxIndex(tree, node) {
		    if (!tree.hasChildNode(node)) {
		        return node;
		    }
		    var childNodes = tree.getChildNodes(node);
		    var length = childNodes.length;
		    if (length == 0) {
		        return node;
		    }
		    return getChildWithMaxIndex(tree, childNodes[length - 1]);
		}

		// tree1 node expand event
		function onNodeExpand(sender, args) {
		    var id = args.node.id;
		    if (id == "root") return;
		    expandChild(sender, args.node);
		}

		// traveling all expaned child node and show the corresponding record.
		function expandChild(tree, node){
		    document.getElementById(rowPrefix + node.id.replace("a_", "")).style.display = "";

		    if (!tree.hasChildNode(node)) {
		        return node;
		    }
		    var childNodes = tree.getChildNodes(node);
		    var length = childNodes.length;
		    for (var i = 0; i < length; i++) {
		        expandChild(tree, childNodes[i]);
		    }
		}

		function clientNodeSelect(sender, args) {
		    var id = args.node.id;
		    var row = -1;

		    if (id != "root_tree1") {
		        row = id.replace("a_", "");
		    }
		    if (row >= 0) {
		        for (var i = 0; i < 21; i++) {
		            if (i == row) {
		                grid1.selectRecord(i);
		            } else {
		                grid1.deselectRecord(i);
		            }
		        }
		    }
		}
		</script>

			<style type="text/css">

	.ob_gC 
	{
		cursor: default;
		padding-right: 0px;
		padding-top: 0px;
		padding-bottom: 0px;
		padding-left: 0px;
		border-right: 0px;
		border-top: 0px;				
		font-family: Verdana;
		font-size: 10px;
		color: #000000;	
		height: 20px;	
		vertical-align: middle;		
	}
		</style>		