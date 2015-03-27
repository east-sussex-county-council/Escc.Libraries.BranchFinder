using System.Data;

namespace Escc.Libraries.BranchFinder.Website
{
    /// <summary>
    /// A data source providing library branch details for the find feature
    /// </summary>
    public interface ILibraryDataSource
    {
        /// <summary>
        /// Adds the libraries from the data source.
        /// </summary>
        /// <param name="table">The table.</param>
        void AddLibraries(DataTable table);
    }
}