using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication8
{
    public partial class Dashboard : System.Web.UI.Page
    {
        private string connString = "Data Source=.;Initial Catalog=SmartOrderDB;Integrated Security=True;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtFromDate.Text = DateTime.Now.AddDays(-30).ToString("yyyy-MM-dd");
                txtToDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                BindSalesData();
            }
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            BindSalesData();
        }

        private void BindSalesData()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"SELECT OrderID, OrderDate, TableNumber, TotalAmount 
                                 FROM Orders 
                                 WHERE CAST(OrderDate AS DATE) BETWEEN @FromDate AND @ToDate 
                                 ORDER BY OrderID DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@FromDate", txtFromDate.Text);
                    cmd.Parameters.AddWithValue("@ToDate", txtToDate.Text);

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);

                        gvSalesHistory.DataSource = dt;
                        gvSalesHistory.DataBind();

                        decimal totalRevenue = 0;
                        int totalOrders = dt.Rows.Count;

                        foreach (DataRow row in dt.Rows)
                        {
                            totalRevenue += Convert.ToDecimal(row["TotalAmount"]);
                        }

                        lblTotalRevenue.Text = totalRevenue.ToString("N2") + " EGP";
                        lblTotalOrders.Text = totalOrders.ToString();
                    }
                }
            }
        }


        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}