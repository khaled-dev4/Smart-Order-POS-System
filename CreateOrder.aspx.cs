using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication8
{
    public partial class CreateOrder : System.Web.UI.Page
    {
        private string connString = "Data Source=.;Initial Catalog=SmartOrderDB;Integrated Security=True;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProductsDropdown();
                InitializeCart();
            }
        }

        private void LoadProductsDropdown()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT ProductID, ProductName + ' (' + CAST(Price AS VARCHAR) + ' EGP)' AS DisplayText FROM Products";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        ddlProducts.DataSource = dt;
                        ddlProducts.DataTextField = "DisplayText";
                        ddlProducts.DataValueField = "ProductID";
                        ddlProducts.DataBind();
                    }
                }
            }
            ddlProducts.Items.Insert(0, new ListItem("-- Select an Item --", "0"));
        }

        private void InitializeCart()
        {
            if (Session["Cart"] == null)
            {
                DataTable dt = new DataTable();
                dt.Columns.Add("ProductID", typeof(int));
                dt.Columns.Add("ProductName", typeof(string));
                dt.Columns.Add("Price", typeof(decimal));
                dt.Columns.Add("Quantity", typeof(int));
                dt.Columns.Add("Total", typeof(decimal), "Price * Quantity");
                Session["Cart"] = dt;
            }
            BindCart();
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            if (ddlProducts.SelectedValue == "0") return;

            int productId = Convert.ToInt32(ddlProducts.SelectedValue);
            DataTable dt = (DataTable)Session["Cart"];

            DataRow[] existingRows = dt.Select("ProductID = " + productId);
            if (existingRows.Length > 0)
            {
                int currentQty = Convert.ToInt32(existingRows[0]["Quantity"]);
                if (currentQty < 99)
                {
                    existingRows[0]["Quantity"] = currentQty + 1;
                }
            }
            else
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    string query = "SELECT ProductName, Price FROM Products WHERE ProductID = @ID";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@ID", productId);
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                DataRow dr = dt.NewRow();
                                dr["ProductID"] = productId;
                                dr["ProductName"] = reader["ProductName"].ToString();
                                dr["Price"] = Convert.ToDecimal(reader["Price"]);
                                dr["Quantity"] = 1;
                                dt.Rows.Add(dr);
                            }
                        }
                    }
                }
            }

            Session["Cart"] = dt;
            BindCart();
        }

        protected void btnIncrease_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int productId = Convert.ToInt32(btn.CommandArgument);
            DataTable dt = (DataTable)Session["Cart"];

            if (dt != null)
            {
                DataRow[] rows = dt.Select("ProductID = " + productId);
                if (rows.Length > 0)
                {
                    int currentQty = Convert.ToInt32(rows[0]["Quantity"]);
                    if (currentQty < 99)
                    {
                        rows[0]["Quantity"] = currentQty + 1;
                    }
                    dt.AcceptChanges();
                }
                Session["Cart"] = dt;
                BindCart();
            }
        }

        protected void btnDecrease_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int productId = Convert.ToInt32(btn.CommandArgument);
            DataTable dt = (DataTable)Session["Cart"];

            if (dt != null)
            {
                DataRow[] rows = dt.Select("ProductID = " + productId);
                if (rows.Length > 0)
                {
                    int currentQty = Convert.ToInt32(rows[0]["Quantity"]);
                    if (currentQty > 1)
                    {
                        rows[0]["Quantity"] = currentQty - 1;
                    }
                    else
                    {
                        rows[0].Delete();
                    }
                    dt.AcceptChanges();
                }
                Session["Cart"] = dt;
                BindCart();
            }
        }

        protected void btnRemove_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int productId = Convert.ToInt32(btn.CommandArgument);
            DataTable dt = (DataTable)Session["Cart"];

            if (dt != null)
            {
                DataRow[] rows = dt.Select("ProductID = " + productId);
                if (rows.Length > 0)
                {
                    rows[0].Delete();
                    dt.AcceptChanges();
                }
                Session["Cart"] = dt;
                BindCart();
            }
        }

        private void BindCart()
        {
            DataTable dt = (DataTable)Session["Cart"];
            gvCart.DataSource = dt;
            gvCart.DataBind();

            decimal grandTotal = 0;
            if (dt != null)
            {
                foreach (DataRow row in dt.Rows)
                {
                    grandTotal += Convert.ToDecimal(row["Total"]);
                }
            }
            lblTotalCart.Text = grandTotal.ToString("N2");
        }

        protected void btnConfirmOrder_Click(object sender, EventArgs e)
        {
            DataTable dt = (DataTable)Session["Cart"];
            if (dt == null || dt.Rows.Count == 0 || Convert.ToDecimal(lblTotalCart.Text) <= 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Your cart is empty! Cannot confirm an empty order.');", true);
                return;
            }

            decimal grandTotal = Convert.ToDecimal(lblTotalCart.Text);

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                string insertOrderQuery = "INSERT INTO Orders (OrderDate, TableNumber, TotalAmount) OUTPUT INSERTED.OrderID VALUES (GETDATE(), 1, @Total)";
                int newOrderId = 0;

                using (SqlCommand cmd = new SqlCommand(insertOrderQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@Total", grandTotal);
                    newOrderId = (int)cmd.ExecuteScalar();
                }

                string insertDetailsQuery = "INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice) VALUES (@OrderID, @ProductID, @Qty, @Price)";
                foreach (DataRow row in dt.Rows)
                {
                    using (SqlCommand cmdDetail = new SqlCommand(insertDetailsQuery, conn))
                    {
                        cmdDetail.Parameters.AddWithValue("@OrderID", newOrderId);
                        cmdDetail.Parameters.AddWithValue("@ProductID", row["ProductID"]);
                        cmdDetail.Parameters.AddWithValue("@Qty", row["Quantity"]);
                        cmdDetail.Parameters.AddWithValue("@Price", row["Price"]);
                        cmdDetail.ExecuteNonQuery();
                    }
                }

                dt.Clear();
                Session["Cart"] = dt;
                Response.Redirect("OrderSuccess.aspx?OrderID=" + newOrderId);
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