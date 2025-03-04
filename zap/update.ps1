import-module au

$releases = 'https://raw.githubusercontent.com/zaproxy/zap-admin/master/ZapVersions.xml'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
  $download_xml = Invoke-WebRequest -Uri $releases -UseBasicParsing
    
	$xml = [xml] ($download_xml)
  
	
	@{
      URL32 = $xml.ZAP.core.windows32.url
      URL64 = $xml.ZAP.core.windows.url
      Version = $xml.ZAP.core.version
  }

}

update
