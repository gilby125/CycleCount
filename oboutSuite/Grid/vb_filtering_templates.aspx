<%@ Page Language="VB" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Grid" Assembly="obout_Grid_NET" %>
<%@ Register TagPrefix="obout" Namespace="Obout.Interface" Assembly="obout_Interface" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<script language="VB" runat="server">
	Dim grid1 As Obout.Grid.Grid = New Grid()    

    Sub Page_load(ByVal sender As Object, ByVal e As EventArgs)
        grid1.ID = "grid1"
        grid1.CallbackMode = True
        grid1.Serialize = True
        grid1.AutoGenerateColumns = False
        
        grid1.FolderStyle = "styles/premiere_blue"
        grid1.AllowFiltering = True
        grid1.ShowLoadingMessage = False

        ' setting the event handlers
        AddHandler CType(grid1, Grid).InsertCommand, AddressOf InsertRecord
        AddHandler CType(grid1, Grid).DeleteCommand, AddressOf DeleteRecord
        AddHandler CType(grid1, Grid).UpdateCommand, AddressOf UpdateRecord
        AddHandler CType(grid1, Grid).Rebind, AddressOf RebindGrid
				
		
        ' creating the Templates
		       
        ' creating the template for the Address column (Filter)
        '------------------------------------------------------------------------		
        Dim TemplateFilterAddress As Obout.Grid.GridRuntimeTemplate
        TemplateFilterAddress = New GridRuntimeTemplate()
        TemplateFilterAddress.ID = "TemplateFilterAddress"
        TemplateFilterAddress.Template = New Obout.Grid.RuntimeTemplate()
        AddHandler CType(TemplateFilterAddress.Template, Obout.Grid.RuntimeTemplate).CreateTemplate, AddressOf CreateFilterAddressTemplate
        TemplateFilterAddress.ControlID = "txtAddress"
        TemplateFilterAddress.ControlPropertyName = "value"
        TemplateFilterAddress.UseQuotes = True
        '------------------------------------------------------------------------

        ' creating the template for the Has Website column (view mode)
        '------------------------------------------------------------------------
        Dim TemplateHasWebsite As Obout.Grid.GridRuntimeTemplate
        TemplateHasWebsite = New GridRuntimeTemplate()
        TemplateHasWebsite.ID = "TemplateHasWebsite"
        TemplateHasWebsite.Template = New Obout.Grid.RuntimeTemplate()
        AddHandler CType(TemplateHasWebsite.Template, Obout.Grid.RuntimeTemplate).CreateTemplate, AddressOf CreateHasWebsiteTemplate
        '------------------------------------------------------------------------

        ' creating the template for the Has Website column (Filter)
        '------------------------------------------------------------------------
        Dim TemplateFilterHasWebsite As Obout.Grid.GridRuntimeTemplate
        TemplateFilterHasWebsite = New GridRuntimeTemplate()
        TemplateFilterHasWebsite.ID = "TemplateFilterHasWebsite"
        TemplateFilterHasWebsite.Template = New Obout.Grid.RuntimeTemplate()
        AddHandler CType(TemplateFilterHasWebsite.Template, Obout.Grid.RuntimeTemplate).CreateTemplate, AddressOf CreateFilterHasWebsiteTemplate
        TemplateFilterHasWebsite.ControlID = "chkHasWebsite"
        TemplateFilterHasWebsite.ControlPropertyName = "checked"
        TemplateFilterHasWebsite.UseQuotes = False
        '------------------------------------------------------------------------
        
        ' creating the template for the Has Website column (edit mode)
        '------------------------------------------------------------------------
        Dim TemplateEditHasWebsite As Obout.Grid.GridRuntimeTemplate
        TemplateEditHasWebsite = New GridRuntimeTemplate()
        TemplateEditHasWebsite.ID = "TemplateEditHasWebsite"
        TemplateEditHasWebsite.Template = New Obout.Grid.RuntimeTemplate()
        AddHandler CType(TemplateEditHasWebsite.Template, Obout.Grid.RuntimeTemplate).CreateTemplate, AddressOf CreateEditHasWebsiteTemplate
        TemplateEditHasWebsite.ControlID = "chkEditHasWebsite"
        TemplateEditHasWebsite.ControlPropertyName = "checked"
        TemplateEditHasWebsite.UseQuotes = False
        '------------------------------------------------------------------------

        ' creating the template for the Country column (Filter)
        '------------------------------------------------------------------------
        Dim TemplateFilterCountry As Obout.Grid.GridRuntimeTemplate
        TemplateFilterCountry = New GridRuntimeTemplate()
        TemplateFilterCountry.ID = "TemplateFilterCountry"
        TemplateFilterCountry.Template = New Obout.Grid.RuntimeTemplate()
        AddHandler CType(TemplateFilterCountry.Template, Obout.Grid.RuntimeTemplate).CreateTemplate, AddressOf CreateFilterCountryTemplate
        TemplateFilterCountry.ControlID = "ddlCountries"
        TemplateFilterCountry.ControlPropertyName = "value"
        TemplateFilterCountry.UseQuotes = True
        '------------------------------------------------------------------------
						
		
        ' adding the templates to the Templates collection        
        grid1.Templates.Add(TemplateFilterAddress)
        grid1.Templates.Add(TemplateHasWebsite)
        grid1.Templates.Add(TemplateFilterHasWebsite)
        grid1.Templates.Add(TemplateEditHasWebsite)
        grid1.Templates.Add(TemplateFilterCountry)
		
																						
        ' creating the columns
        Dim oCol1 As Column = new Column()
        oCol1.DataField = "SupplierID"
        oCol1.ReadOnly = True
        oCol1.HeaderText = "ID"
        oCol1.Width = "75"

        Dim oCol2 As Column = new Column()
        oCol2.DataField = "CompanyName"
        oCol2.HeaderText = "Company Name"
        oCol2.Width = "250"
	
        Dim oCol3 As Column = new Column()
        oCol3.DataField = "Address"
        oCol3.HeaderText = "Address"
        oCol3.Width = "175"
        oCol3.TemplateSettings.FilterTemplateId = "TemplateFilterAddress"
        oCol3.ShowFilterCriterias = False

        Dim oCol4 As Column = new Column()
        oCol4.DataField = "Country"
        oCol4.HeaderText = "Country"
        oCol4.Width = "150"
        oCol4.TemplateSettings.FilterTemplateId = "TemplateFilterCountry"
        oCol4.ShowFilterCriterias = False
	
        Dim oCol5 As Column = new Column()
        oCol5.DataField = "HomePage"
        oCol5.HeaderText = "Has WebSite"
        oCol5.Width = "125"
        oCol5.TemplateSettings.TemplateId = "TemplateHasWebsite"
        oCol5.TemplateSettings.EditTemplateId = "TemplateEditHasWebsite"
        oCol5.TemplateSettings.FilterTemplateId = "TemplateFilterHasWebsite"
        oCol5.ShowFilterCriterias = False

        Dim oCol6 As Column = new Column()
        oCol6.HeaderText = "EDIT"
        oCol6.Width = "125"
        oCol6.AllowEdit = True
        oCol6.AllowDelete = True

        ' add the columns to the Columns collection of the grid
        grid1.Columns.Add(oCol1)
        grid1.Columns.Add(oCol2)
        grid1.Columns.Add(oCol3)
        grid1.Columns.Add(oCol4)
        grid1.Columns.Add(oCol5)
        grid1.Columns.Add(oCol6)                        
		
        ' add the grid to the controls collection of the PlaceHolder
        phGrid1.Controls.Add(grid1)
				
        If Not Page.IsPostBack Then
            BindGrid()
        End If
    End Sub

	' Create the methods that will load the data into the templates
	
    '------------------------------------------------------------------------
    Sub CreateFilterAddressTemplate(ByVal sender As Object, ByVal e As Obout.Grid.GridRuntimeTemplateEventArgs)
        Dim oLiteral As Literal = New Literal()
        e.Container.Controls.Add(oLiteral)
        AddHandler CType(oLiteral, Literal).DataBinding, AddressOf DataBindFilterAddressTemplate
    End Sub
    Sub DataBindFilterAddressTemplate(ByVal sender As Object, ByVal e As EventArgs)
        Dim oLiteral As Literal = CType(sender, Literal)
        Dim oContainer As Obout.Grid.TemplateContainer
        oContainer = CType(oLiteral.NamingContainer, Obout.Grid.TemplateContainer)

        oLiteral.Text = "<textarea id=""txtAddress"" rows=""3"" class=""ob_gEC"" style=""overflow: auto;""></textarea>"
    End Sub
	'------------------------------------------------------------------------

	'------------------------------------------------------------------------
	Sub CreateHasWebsiteTemplate(ByVal sender As Object, ByVal e As Obout.Grid.GridRuntimeTemplateEventArgs)	
		Dim oLiteral As Literal = New Literal()
		e.Container.Controls.Add(oLiteral)		
		AddHandler CType(oLiteral, Literal).DataBinding, AddressOf DataBindHasWebsiteTemplate
	End Sub
	Sub DataBindHasWebsiteTemplate(ByVal sender As Object, ByVal e As EventArgs)
		Dim oLiteral As Literal = CType(sender, Literal)
		Dim oContainer As Obout.Grid.TemplateContainer
		oContainer = CType(oLiteral.NamingContainer, Obout.Grid.TemplateContainer)
		
		If oContainer.Value = "true" Then
			oLiteral.Text = "yes"
		Else
			oLiteral.Text = "no"
		End If
	End Sub
	'------------------------------------------------------------------------

    '------------------------------------------------------------------------
    Sub CreateFilterHasWebsiteTemplate(ByVal sender As Object, ByVal e As Obout.Grid.GridRuntimeTemplateEventArgs)
        Dim oLiteral As Literal = New Literal()
        e.Container.Controls.Add(oLiteral)
        AddHandler CType(oLiteral, Literal).DataBinding, AddressOf DataBindFilterHasWebsiteTemplate
    End Sub
    Sub DataBindFilterHasWebsiteTemplate(ByVal sender As Object, ByVal e As EventArgs)
        Dim oLiteral As Literal = CType(sender, Literal)
        Dim oContainer As Obout.Grid.TemplateContainer
        oContainer = CType(oLiteral.NamingContainer, Obout.Grid.TemplateContainer)

        oLiteral.Text = "<input type=""checkbox"" id=""chkHasWebsite""/>"
    End Sub
    '------------------------------------------------------------------------
    
    '------------------------------------------------------------------------
	Sub CreateEditHasWebsiteTemplate(ByVal sender As Object, ByVal e As Obout.Grid.GridRuntimeTemplateEventArgs)	
		Dim oLiteral As Literal = New Literal()
		e.Container.Controls.Add(oLiteral)		
		AddHandler CType(oLiteral, Literal).DataBinding, AddressOf DataBindEditHasWebsiteTemplate
	End Sub
	Sub DataBindEditHasWebsiteTemplate(ByVal sender As Object, ByVal e As EventArgs)
		Dim oLiteral As Literal = CType(sender, Literal)
		Dim oContainer As Obout.Grid.TemplateContainer
		oContainer = CType(oLiteral.NamingContainer, Obout.Grid.TemplateContainer)

        oLiteral.Text = "<input type=""checkbox"" id=""chkEditHasWebsite""/>"
	End Sub
	'------------------------------------------------------------------------

	'------------------------------------------------------------------------
    Sub CreateFilterCountryTemplate(ByVal sender As Object, ByVal e As Obout.Grid.GridRuntimeTemplateEventArgs)
        Dim ph1 As PlaceHolder = New PlaceHolder()
        e.Container.Controls.Add(ph1)
        AddHandler CType(ph1, PlaceHolder).DataBinding, AddressOf DataBindFilterCountryTemplate
    End Sub
    Sub DataBindFilterCountryTemplate(ByVal sender As Object, ByVal e As EventArgs)
        Dim ph1 As PlaceHolder = CType(sender, PlaceHolder)
        Dim oContainer As Obout.Grid.TemplateContainer
        oContainer = CType(ph1.NamingContainer, Obout.Grid.TemplateContainer)

        Dim ddlCountries As OboutDropDownList = New OboutDropDownList()
        
        ddlCountries.ID = "ddlCountries"
        ddlCountries.Width = Unit.Percentage(100)
        ddlCountries.MenuWidth = Unit.Pixel(175)
        
        ddlCountries.FolderStyle = "styles/premiere_blue/interface/OboutDropDownList"
        
        ddlCountries.Items.Add(New ListItem("Australia", "Australia"))
        ddlCountries.Items.Add(New ListItem("Austria", "Austria"))
        ddlCountries.Items.Add(New ListItem("Brazil", "Brazil"))
        ddlCountries.Items.Add(New ListItem("France", "France"))
        ddlCountries.Items.Add(New ListItem("Germany", "Germany"))
        ddlCountries.Items.Add(New ListItem("UK", "UK"))
        ddlCountries.Items.Add(New ListItem("USA", "USA"))
        
        ph1.Controls.Add(ddlCountries)
    End Sub
	'------------------------------------------------------------------------


	Sub BindGrid()	
		Dim myConn As OleDbConnection = New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("../App_Data/Northwind.mdb"))

		Dim myComm As OleDbCommand = New OleDbCommand("SELECT * FROM Suppliers", myConn)
		myConn.Open()
		Dim myReader As OleDbDataReader = myComm.ExecuteReader()

		grid1.DataSource = myReader
		grid1.DataBind()

		myConn.Close()
	End Sub
		
    Sub DeleteRecord(ByVal sender As Object, ByVal e As GridRecordEventArgs)
        Dim myConn As OleDbConnection = New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("../App_Data/Northwind.mdb"))
        myConn.Open()
        
        Dim myComm As OleDbCommand = New OleDbCommand("DELETE FROM Suppliers WHERE SupplierID = @SupplierID", myConn)
        
        myComm.Parameters.Add("@SupplierID", OleDbType.Integer).Value = e.Record("SupplierID")
        
        myComm.ExecuteNonQuery()
        myConn.Close()
    End Sub
	
    Sub UpdateRecord(ByVal sender As Object, ByVal e As GridRecordEventArgs)
        Dim myConn As OleDbConnection = New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("../App_Data/Northwind.mdb"))
        myConn.Open()
        
        Dim myComm As OleDbCommand = New OleDbCommand("UPDATE Suppliers SET CompanyName = @CompanyName, Address = @Address, Country=@Country, HomePage=@HomePage WHERE SupplierID = @SupplierID", myConn)

        myComm.Parameters.Add("@CompanyName", OleDbType.VarChar).Value = e.Record("CompanyName")
        myComm.Parameters.Add("@Address", OleDbType.VarChar).Value = e.Record("Address")
        myComm.Parameters.Add("@Country", OleDbType.VarChar).Value = e.Record("Country")
        myComm.Parameters.Add("@HomePage", OleDbType.VarChar).Value = e.Record("HomePage")
        myComm.Parameters.Add("@SupplierID", OleDbType.Integer).Value = e.Record("SupplierID")
        
        myComm.ExecuteNonQuery()
        myConn.Close()
    End Sub
	
    Sub InsertRecord(ByVal sender As Object, ByVal e As GridRecordEventArgs)
        Dim myConn As OleDbConnection = New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("../App_Data/Northwind.mdb"))
        myConn.Open()
		
        Dim myComm As OleDbCommand = New OleDbCommand("INSERT INTO Suppliers (CompanyName, Address, Country, HomePage) VALUES(@CompanyName, @Address, @Country, @HomePage)", myConn)
		
        myComm.Parameters.Add("@CompanyName", OleDbType.VarChar).Value = e.Record("CompanyName")
        myComm.Parameters.Add("@Address", OleDbType.VarChar).Value = e.Record("Address")
        myComm.Parameters.Add("@Country", OleDbType.VarChar).Value = e.Record("Country")
        myComm.Parameters.Add("@HomePage", OleDbType.VarChar).Value = e.Record("HomePage")
  
        myComm.ExecuteNonQuery()
        myConn.Close()
    End Sub
	
	Sub RebindGrid(ByVal sender As Object, ByVal e As EventArgs)	
		BindGrid()
	End Sub
	</script>		

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> <html>
	<head>
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
		</style>		
	</head>
	<body>	
		<form runat="server">
					
		<br />
		<span class="tdText"><b>ASP.NET Grid - Filter Templates</b></span>
		<br /><br />			
			
		<asp:PlaceHolder ID="phGrid1" runat="server"></asp:PlaceHolder>
		
		<br /><br /><br />
		
		<span class="tdText">
		Use the <b>FilterTemplateId</b> property of the <b>Column class</b> to specify a template<br />
		that should be used for the filter of a column.<br /><br />
		The Filter Criterias Selector can be shown also if a Column uses a template for the filter<br />
		(just set <b>ShowFilterCriterias</b> to <span class="option2">true</span>)
		<br /><br />
		See the <a href="http://www.obout.com/grid/grid_tutorials_templates.aspx">Templates tutorial</a>
		</span>


		<br /><br /><br />
		
		<a href="Default.aspx?type=VBNET">� Back to examples</a>
		
		</form>
	</body>
</html>