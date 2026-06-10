using System;
using System.Data;
using System.Data.SqlClient;

namespace WebApplication8
{
    public partial class OrderSuccess : System.Web.UI.Page
    {
        private string connString = "Data Source=.;Initial Catalog=SmartOrderDB;Integrated Security=True;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["OrderID"] != null)
                {
                    string orderId = Request.QueryString["OrderID"].ToString();
                    lblOrderId.Text = orderId;
                    LoadReceiptData(Convert.ToInt32(orderId));
                }
            }
        }

        private void LoadReceiptData(int orderId)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                // جلب المنتجات والكميات المربوطة بالفاتورة دي بالظبط
                string query = @"SELECT p.ProductName, od.Quantity, (od.Quantity * od.UnitPrice) as Total, o.TotalAmount 
                                 FROM OrderDetails od 
                                 JOIN Products p ON od.ProductID = p.ProductID 
                                 JOIN Orders o ON od.OrderID = o.OrderID 
                                 WHERE od.OrderID = @OrderID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@OrderID", orderId);
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            gvReceiptDetails.DataSource = dt;
                            gvReceiptDetails.DataBind();

                            // عرض الإجمالي الكبير للفاتورة
                            lblTotalAmount.Text = Convert.ToDecimal(dt.Rows[0]["TotalAmount"]).ToString("N2");
                        }
                    }
                }
            }
        }
    }
}