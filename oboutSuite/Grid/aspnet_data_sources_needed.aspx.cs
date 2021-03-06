﻿using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Obout.Grid;
using System.Data.OleDb;
using System.Data;

public partial class Grid_aspnet_data_sources_needed : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Grid1_DataSourceNeeded(object sender, GridDataSourceNeededEventArgs e)
    {
        // Preparing the SQL query for populating the Grid
        string sortExpression = "";
        string filterExpression = "";        

        if (string.IsNullOrEmpty(e.SortExpression))
        {
            sortExpression = " ORDER BY OrderID DESC";
        }
        else
        {
            sortExpression = " ORDER BY " + e.SortExpression;
        }

        if (!string.IsNullOrEmpty(e.FilterExpression))
        {
            filterExpression = e.FilterExpression;
        }

        string query = "SELECT TOP " + e.MaximumRows.ToString() + " * FROM (SELECT OrderID, ShipName, ShipCity, ShipAddress, ShipPostalCode, ShipCountry FROM Orders";
        if (e.StartRowIndex != 0)
        {
            query += " WHERE OrderID NOT IN (SELECT TOP " + e.StartRowIndex.ToString() + " OrderID FROM Orders";
            query += (string.IsNullOrEmpty(filterExpression) ? "" : " WHERE " + filterExpression) + sortExpression + ")";
            if (!string.IsNullOrEmpty(filterExpression))
            {
                query += " AND " + filterExpression;
            }
        }
        else
        {
            if (!string.IsNullOrEmpty(filterExpression))
            {
                query += " WHERE " + filterExpression;
            }
        }        
        query += sortExpression + ")";

        // Extracting the rows
        OleDbConnection myConn = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("../App_Data/Northwind.mdb"));
        OleDbCommand myComm = new OleDbCommand(query, myConn);
        myConn.Open();
        OleDbDataAdapter da = new OleDbDataAdapter();
        DataSet ds = new DataSet();
        da.SelectCommand = myComm;
        da.Fill(ds, "Orders");


        string countQuery = "SELECT COUNT(*) FROM Orders";
        if (!string.IsNullOrEmpty(filterExpression))
        {
            countQuery += " WHERE " + filterExpression;
        }
        
        // Retrieving the total count of rows
        OleDbConnection myConn2 = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + System.Web.HttpContext.Current.Server.MapPath("../App_Data/Northwind.mdb"));
        OleDbCommand myComm2 = new OleDbCommand(countQuery, myConn2);
        myConn2.Open();
        int count = (int)(myComm2.ExecuteScalar());

        myConn2.Close();

        // Passing the total count to the "TotalRowCount" property of the GridDataSourceNeededEventArgs object
        e.TotalRowCount = count;

        // Populating the grid
        Grid1.DataSource = ds.Tables[0];
        Grid1.DataBind();
    }
}