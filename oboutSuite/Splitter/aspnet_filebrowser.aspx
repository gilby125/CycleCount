<%@ Page Language="C#" ASPCOMPAT="TRUE" Debug="true" Inherits="OboutInc.oboutAJAXPage"%>
<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.TreeView" TagPrefix="obout" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Register TagPrefix="ogrid" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage" %> 
<%@ Register TagPrefix="obspl" Namespace="OboutInc.Splitter2" Assembly="obout_Splitter2_Net" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script language="C#" runat="server">
    protected Tree obClassicTree = null;
    string initialDirectory = "resources/FileBrowser";
	string DefaultFolder;
	int expandedLevel = 0;
	
	void Page_Load(object sender, EventArgs e) {

		DefaultFolder = Server.MapPath(initialDirectory);
		
		ThrowExceptionsAtClient = false;
		ShowErrorsAtClient = false;
		
		LoadTreeView();
		
		// set default initial directory
		if (!IsPostBack)
			SelectDir(initialDirectory);
		
    }

    private void LoadTreeView()
    {
        DirectoryInfo rootFolder = new DirectoryInfo(DefaultFolder);

        obClassicTree = new Tree()
        {
            ID = "ObClassicTree",
            OnNodeSelect = "clientOnNodeSelect",
            CssClass = "default",
            Width = 150
        };
        obClassicTree.RootNodeStyle.NodeCSS = "myroot";
        obClassicTree.RootNodeStyle.SubNodeContainerCSS = "mycontainer";

        Node nodeLib = new Node()
        {
            Text = "<span style='cursor:pointer'>File Browser</span>",
            Expanded = true,
            Selected = true,
            Value = initialDirectory,
            ImageUrl = "~/TreeView/img/library.png"
        };
        this.obClassicTree.Nodes.Add(nodeLib);
        LoadDirRecursive(rootFolder, nodeLib);
        this.TreePlaceHolder.Controls.Add(obClassicTree);
    }

    private void LoadDirRecursive(DirectoryInfo rootFolder, Node oNode)
    {
        expandedLevel++;

        foreach (DirectoryInfo dir in rootFolder.GetDirectories())
        {
            string dirName = dir.Name;

            bool expanded = true;
            if (expandedLevel >= 15)
                expanded = false;

            string textDirName = "<span style='cursor:pointer'>" + dirName + "</span>";
            Node newNode = new Node()
            {
                Text = textDirName,
                Expanded = expanded,
                Value = oNode.Value + "/" +dirName,
                ImageUrl = "~/TreeView/img/folder.png"
            };
            oNode.ChildNodes.Add(newNode);
            LoadDirRecursive(new DirectoryInfo(rootFolder + "/" + dirName), newNode);
        }
    }
	
	// populate grid with directory content
	public void SelectDir(string dir)
	{
		ViewState["dir"] = dir;
		
		LoadGrid();
		
		UpdatePanel("cpDir");
	}
	
	public void LoadGrid()
	{
		DataSet dsDir = new DataSet();
		dsDir.Tables.Add(new DataTable());
		dsDir.Tables[0].Columns.Add(new DataColumn("name", System.Type.GetType("System.String")));
		dsDir.Tables[0].Columns.Add(new DataColumn("size", System.Type.GetType("System.Int32")));
		dsDir.Tables[0].Columns.Add(new DataColumn("type", System.Type.GetType("System.String")));
		dsDir.Tables[0].Columns.Add(new DataColumn("datemodified", System.Type.GetType("System.String")));
		dsDir.Tables[0].Columns.Add(new DataColumn("imageType", System.Type.GetType("System.String")));

        DirectoryInfo rootFolder = new DirectoryInfo(Server.MapPath(ViewState["dir"].ToString()));
		
		foreach (DirectoryInfo dir in rootFolder.GetDirectories()) 
		{
			string dirName = dir.Name;
			string dirDateTime = dir.LastAccessTime.ToString("d/M/yyyy h:m:s tt");
			string dirImageType = "Folder";
			dsDir.Tables[0].Rows.Add(new object[] {dirName, 0, "File Folder", dirDateTime, dirImageType});
		}
		
		foreach (FileInfo file in rootFolder.GetFiles()) 
		{
			string fileName = file.Name;
			string fileSize = file.Length.ToString();
			string fileType = file.Extension.Replace(".", "");
			string fileImageType = "File";
			string fileDateTime = file.LastAccessTime.ToString("d/M/yyyy h:m:s tt");
			
			dsDir.Tables[0].Rows.Add(new object[] {fileName, fileSize, fileType, fileDateTime, fileImageType});
		}
		
		gridDir.DataSource = dsDir;
		gridDir.DataBind();
	}
	
</script>
<script type="text/javascript">

function SelectDir(dir)
{
	ob_post.AddParam("dir", dir);
	ob_post.post(null, "SelectDir", function(){});
}
function clientOnNodeSelect(sender, args) {
    var obTree = $find("<%=obClassicTree.ClientID%>");
    SelectDir(obTree.getNodeValue(args.node));
}

</script>

<html>
	<head id="Head1" runat="server">
	    <title>obout ASP.NET Splitter examples</title>
    	   
		<style type="text/css">
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
	<body>
        <form id="Form1" runat="server">
            <asp:ScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />
	        <br />
		    <span class="tdText"><b>ASP.NET Splitter - File Browser</b></span>
    	
		    <br /><br />
		    <a style="font-size:10pt;font-family:Tahoma" href="Default.aspx?type=ASPNET">« Back to examples</a>
		    <br /><br />
            <table border="0">
	            <tr>
		            <td valign="top" class="h5" width="630">
			            You can browse a folder on your disk, <span style="color:crimson;">without reloading the page</span>.
			            <br />
		            </td>
	            </tr>
	            <tr>
		            <td valign="top" class="h5">	            			            
			            <div style="border:1px solid gray;width:680px;height:370px;">
				            <div style="width:680px;height:370px;">
					            <obspl:Splitter id="sp1" runat="server" StyleFolder="styles/default">
						            <LeftPanel WidthDefault="169" WidthMin="169" WidthMax="350">
							            <Header height="30">
								            <div style="padding-left:10px;padding-top:5px;padding-bottom:5px;background-color:#C0C0C0" class="tdText">
									            <b style="font-size:10px">Folders</b>
								            </div>
							            </Header>
							            <Content>
								            <div style="padding-top:7px;padding-left:10px;border-top:1px solid gray">
									            <asp:PlaceHolder ID="TreePlaceHolder" runat="server"></asp:PlaceHolder>
								            </div>
							            </Content>
						            </LeftPanel>
						            <RightPanel>
							            <Content>
								            <div style="padding-top:0px;padding-left:0px;">
									            <oajax:CallbackPanel id="cpDir" runat="server">
										            <content>
											            <ogrid:Grid id="gridDir" runat="server" AllowRecordSelection="true" ShowFooter="false"
												            KeepSelectedRecords="false" AllowAddingRecords="false" CallbackMode="true" Serialize="false" 
												            AllowColumnResizing="true" ShowHeader="true" Width="100%"
												            PageSize="100" FolderStyle="../grid/styles/style_5" AutoGenerateColumns="false">
												            <Columns>
													            <ogrid:Column DataField="imageType" HeaderText="" Width="53" runat="server">
													                <TemplateSettings TemplateId="tplImageType" />
													            </ogrid:Column>
													            <ogrid:Column DataField="Name" HeaderText="Name" Width="120" runat="server" />
													            <ogrid:Column DataField="Size" HeaderText="Size" Width="80" runat="server">
													                <TemplateSettings TemplateId="tplSize" />
													            </ogrid:Column>
													            <ogrid:Column DataField="Type" HeaderText="Type" Width="83" runat="server" />
													            <ogrid:Column DataField="DateModified" HeaderText="Date Modified" Width="167" runat="server" />
												            </Columns>	
												            <Templates>
													            <ogrid:GridTemplate runat="server" ID="tplImageType">
														            <Template>
															            <div style="width:100%;height:100%;text-align:right;padding-top:4px">
																            <img src="images/filebrowser/<%# Container.Value %>.gif" />
															            </div>
														            </Template>
													            </ogrid:GridTemplate>
													            <ogrid:GridTemplate runat="server" ID="tplSize">
														            <Template>
															            <div style="width:100%;height:100%;padding-left:10px;padding-top:6px">
																            <%# Container.Value == "0" ? "" : Container.Value + " KB" %>
															            </div>
														            </Template>
													            </ogrid:GridTemplate>
												            </Templates>
											            </ogrid:Grid>	
										            </content>
										            <loading>
											            <table width=100% height=100% cellpadding=0 cellspacing=0>
												            <tr>
													            <td align=center>
														            <img src="Resources/loading_icons/1.gif">
													            </td>
												            </tr>
											            </table>
										            </loading>
									            </oajax:CallbackPanel>
									            <oajax:CallbackPanel id="cpLabel" runat="server">
										            <content>
											            <asp:Label id="lblDir" runat="server" />
										            </content>
									            </oajax:CallbackPanel>
								            </div>
							            </Content>
						            </RightPanel>
					            </obspl:Splitter>
				            </div>
			            </div>
		            </td>	
	            </tr>
            </table>
        </form>
    </body>
</html>

<script type="text/javascript">
function ob_OnNodeSelect(id)
{   
	SelectDir(id);
}
</script>

