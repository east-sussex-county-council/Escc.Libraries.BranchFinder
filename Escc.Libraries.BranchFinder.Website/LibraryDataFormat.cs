using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;

namespace Escc.Libraries.BranchFinder.Website
{
    /// <summary>
    /// Library data is managed in a DataSet format for the search. This creates the DataSet.
    /// </summary>
    public static class LibraryDataFormat
    {
        public static DataSet CreateDataSet()
        {
             // Dataset to hold the library table
            using (DataSet ds = new DataSet())
            {
                ds.Locale = CultureInfo.CurrentCulture;

                using (DataTable dt = new DataTable())
                {
                    dt.Locale = CultureInfo.CurrentCulture;
                    DataColumn dcName = new DataColumn("Name");
                    dt.Columns.Add(dcName);
                    DataColumn url = new DataColumn("URL");
                    dt.Columns.Add(url);
                    DataColumn lat = new DataColumn("Latitude");
                    dt.Columns.Add(lat);
                    DataColumn lon = new DataColumn("Longitude");
                    dt.Columns.Add(lon);
                    DataColumn dcDescription = new DataColumn("Description");
                    dt.Columns.Add(dcDescription);
                    // the following apply only to mobile libraries
                    DataColumn dcTown = new DataColumn("Town");
                    dt.Columns.Add(dcTown);
                    DataColumn dcLocation = new DataColumn("Location");
                    dt.Columns.Add(dcLocation);
                    DataColumn type = new DataColumn("LocationType");
                    dt.Columns.Add(type);
                    //add the table to our dataset and accept all changes
                    ds.Tables.Add(dt);

                    ds.AcceptChanges();
                }
                
                return ds;
            }
        }
    }
}