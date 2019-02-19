using System;
using System.Xml;
using System.Data;
using System.Data.OleDb;
using System.Web.UI.WebControls;
using Obout.ComboBox;

public class cs_livesearch : OboutInc.oboutAJAXPage
{
	protected DataList hotelList;
	protected Literal lDestination;
	protected Literal lCheckIn;
	protected Literal lCheckOut;
	protected Literal lAdults;
	protected Literal lChildren;
	protected Literal lRooms;
	protected Obout.ComboBox.ComboBox cboLocation;
	protected OboutInc.Calendar2.Calendar myCalendar1;
	protected OboutInc.Calendar2.Calendar myCalendar2;
	
    void Page_Load(object sender, EventArgs e) {
        
		if (!IsPostBack)
		{
			PopulateWithData();
			myCalendar1.SelectedDate = DateTime.Now.AddDays(7);
			myCalendar1.DateMin = DateTime.Now.AddDays(7);
			myCalendar2.SelectedDate = DateTime.Now.AddDays(10);
			myCalendar2.DateMin = DateTime.Now.AddDays(7);
		}
		
		if (IsCallback && Session["SearchParams"] != null)
		{
			Search();
			Session["SearchParams"] = null;
		}
	}

    public void PopulateWithData()
    {
        // Setting the connection
        OleDbConnection oConn = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("../App_Data/hotels.mdb"));
        oConn.Open();

        // Run the query to retrieve the words that start with the give text
        string sQuery = "SELECT DISTINCT LocationID, Location FROM Location ORDER BY Location ASC";
        OleDbCommand oCommand = new OleDbCommand(sQuery);
        oCommand.Connection = oConn;
        OleDbDataReader oReader = oCommand.ExecuteReader();

        // Looping through the database records and adding them to the XML string
        while (oReader.Read())
        {
            ComboBoxItem item1 = new ComboBoxItem();
            item1.Value = oReader.GetInt32(0).ToString();
            item1.Text = oReader.GetString(1);
            cboLocation.Items.Add(item1);
        }
        
		// Closing the connection
        oReader.Close();
        oConn.Close();
    }
	
	// set the search params - keep in session object
	public void SetSearchParams(string location, string locationID, string checkIn, string checkOut, string rooms, string adults, string children)
	{
		SearchParams sp = new SearchParams();
		sp.location = location;
		sp.locationID = locationID;
		sp.checkIn = checkIn;
		sp.checkOut = checkOut;
		sp.rooms = rooms;
		sp.adults = adults;
		sp.children = children;
		
		Session["SearchParams"] = sp;
	}
	
	// search - in real life application - use all the search params to retreive the data from the database
	public void Search()
	{
		OleDbConnection myConn = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("../App_Data/hotels.mdb"));
		myConn.Open();
		
		// get random results from the database
		if (Session["random"] == null) Session["random"] = 1;
		else Session["random"] = Int32.Parse(Session["random"].ToString()) % 5 + 1;
		string query = "SELECT name, stars, description, price, image FROM hotels where locationID = " + Session["random"].ToString();
		
		OleDbCommand myComm = new OleDbCommand(query, myConn);
		OleDbDataReader myReader = myComm.ExecuteReader();
		
		hotelList.DataSource = myReader;
		hotelList.DataBind();
		
		// populate search params details - header of the search panel
		lDestination.Text = ((SearchParams)Session["SearchParams"]).location;
		lCheckIn.Text = ((SearchParams)Session["SearchParams"]).checkIn;
		lCheckOut.Text = ((SearchParams)Session["SearchParams"]).checkOut;
		lAdults.Text = ((SearchParams)Session["SearchParams"]).adults;
		lChildren.Text = ((SearchParams)Session["SearchParams"]).children;
		lRooms.Text = ((SearchParams)Session["SearchParams"]).rooms;
	}
	
	public class SearchParams
	{
		public SearchParams(){}
		
		private string _location;
		private string _locationID;
		private string _checkIn;
		private string _checkOut;
		private string _rooms;
		private string _adults;
		private string _children;
		
		public string location
		{
			get { return _location; }
			set { _location = value; }
		}
		public string locationID
		{
			get { return _locationID; }
			set { _locationID = value; }
		}
		public string checkIn
		{
			get { return _checkIn; }
			set { _checkIn = value; }
		}
		public string checkOut
		{
			get { return _checkOut; } 
			set { _checkOut = value; }
		}
		public string rooms
		{
			get { return _rooms; }
			set { _rooms = value; }
		}
		public string adults
		{
			get { return _adults; }
			set { _adults = value; }
		}
		public string children
		{
			get { return _children; }
			set { _children = value; }
		}
	}	
}