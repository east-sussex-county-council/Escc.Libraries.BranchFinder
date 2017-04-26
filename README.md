# Escc.Libraries.BranchFinder

'Find your library' tool for www.eastsussex.gov.uk.

This tool relies on two external tools: 

* an implementation of the GOV.UK [locate-api](https://github.com/alphagov/locate-api), which can look up a postcode and return a latitude and longitude for the centre point.

	This requires two entries in the `appSettings` section of `web.config`:

		<appSettings>
			<add key="LocateApiToken" value="12345"/>
		    <add key="LocateApiUrl" value="https://hostname/locate/authority?postcode={0}"/>
		</appSettings>

* an API, defined in the `Escc.EastSussexGovUK.Umbraco` project, which provides library data as JSON.

	This requires the URL to be set in the `appSettings` section of `web.config`:
	
		<appSettings>
    		<add key="LibraryDataUrl" value="https://hostname/umbraco/api/location/list?type=Library&amp;type=MobileLibraryStop"/>
		</appSettings>


Both of these are implemented as interfaces which can be replaced with alternative implementations.

One more entry in `appSettings` is required in `web.config`, which is a base URL used to link to a page for each library from hard-coded content.

		<appSettings>
    		<add key="UmbracoBaseUrl" value="https://hostname" />
		<appSettings>

## Development setup steps

1. Install [NuBuild](https://github.com/bspell1/NuBuild)
2. From an Administrator command prompt, run `app-setup-dev.cmd` to set up a site in IIS.
3. Build the solution
9. In `~\web.config` uncomment and complete the `Proxy` section, and update the three URLs for the web service, library data API and mobile library times page.