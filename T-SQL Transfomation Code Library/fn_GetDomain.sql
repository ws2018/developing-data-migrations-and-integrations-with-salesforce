
CREATE FUNCTION [dbo].[fn_GetDomain]  (@strURL nvarchar(1000))
RETURNS nvarchar(1000)
AS
BEGIN
IF CHARINDEX('http://',@strURL) > 0 OR CHARINDEX('https://',@strURL) > 0
SELECT @strURL = REPLACE(@strURL,' ','')
SELECT @strURL = REPLACE(@strURL,'https://','')
SELECT @strURL = REPLACE(@strURL,'http://','')
SELECT @strURL = REPLACE(@strURL,'www.','')
SELECT @strURL = REPLACE(@strURL,'www','')
SELECT @strURL = REPLACE(@strURL,'ftp://','')
-- Remove everything after "/" if one exists

IF CHARINDEX('/',@strURL) > 0 (SELECT @strURL = LEFT(@strURL,CHARINDEX('/',@strURL)-1))
	 --Optional: Remove subdomains but differentiate between www.google.com and www.google.com.au
	--IF (LEN(@strURL)-LEN(REPLACE(@strURL,'.','')))/LEN('.') < 3 -- if there are less than 3 periods
	--SELECT @strURL = PARSENAME(@strURL,2) + '.' + PARSENAME(@strURL,1)
	--ELSE -- It's likely a google.co.uk, or google.com.au
	--SELECT @strURL = PARSENAME(@strURL,3) + '.' + PARSENAME(@strURL,2) + '.' + PARSENAME(@strURL,1)
RETURN @strURL
END