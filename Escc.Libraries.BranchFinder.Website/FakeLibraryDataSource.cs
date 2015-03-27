using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace Escc.Libraries.BranchFinder.Website
{
    public class FakeLibraryDataSource : ILibraryDataSource
    {
        public void AddLibraries(DataTable table)
        {
            var lewes = table.NewRow();
            lewes["Name"] = "Lewes Library";
            lewes["URL"] = "/libraries/lewes.htm";
            lewes["Latitude"] = "50.872872";
            lewes["Longitude"] = "0.013526";
            lewes["Description"] = "This is a town library with a range of books, talking books, DVDs, music CDs, a reference and large local studies section and free Internet access. It has disabled access.";
            table.Rows.Add(lewes);

            var uckfield = table.NewRow();
            uckfield["Name"] = "Uckfield Library";
            uckfield["URL"] = "/libraries/uckfield.htm";
            uckfield["Latitude"] = "50.972144";
            uckfield["Longitude"] = "0.096452";
            uckfield["Description"] = "A town library with a range of books, audiobooks, DVDs, a reference and local studies section and free Internet access. It has disabled access.";
            table.Rows.Add(uckfield);

            var crowborough = table.NewRow();
            crowborough["Name"] = "Crowborough Library";
            crowborough["URL"] = "/libraries/crowborough.htm";
            crowborough["Latitude"] = "51.058695";
            crowborough["Longitude"] = "0.158844";
            crowborough["Description"] = "A town library with a range of books, talking books, DVDs, a reference and local studies section and free Internet access. It has disabled access.";
            table.Rows.Add(crowborough);
        }
    }
}