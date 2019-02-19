using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;

public partial class SmartImage_cs_DataTableDataSource : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string connectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + System.Web.HttpContext.Current.Server.MapPath(ResolveUrl("~/App_Data/FilesRepository.mdb")) + ";";
        OleDbConnection connection = new OleDbConnection();
        try
        {
            connection.ConnectionString = connectionString;
            connection.Open();

            string sqlString = "Select * from tbImage";
            OleDbDataAdapter eAdapter = new OleDbDataAdapter(sqlString, connection);
            DataTable eTable = new DataTable();
            OleDbCommandBuilder CommandBuilder = new OleDbCommandBuilder(eAdapter);
            eAdapter.Fill(eTable);

            imageset.DataSource = eTable;
            imageset.DataBind();
        }
        finally
        {
            connection.Close();
            connection.Dispose();
        }

    }
}