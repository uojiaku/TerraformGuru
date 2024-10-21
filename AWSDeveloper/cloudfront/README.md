# CloudFront

A distributed content delivery service for simple static asset caching up to 4k live and on-demand video streaming
- Integrated with Amazon Certificate Manager and supports SNI

## SSL, TLS, SNI
SSL and TLS are often used/spoken of interchangeably.
We can use the default CloudFront cert, but if we want to serve up our own content using a custom domain we have to use our own custom SSL certificate. We can generate a certificate from AWS certificate manager or purchase one from a 3rd party issuer and upload it into IAM. 
 - If we use a cert with a wildcard at the front, the cert will be good for any subdomain that I wish to add on. If we do choose to use a custom domain and selected a custom SSL certificates, there's one issue. One of SSLs main functions is to guarantee that I'm visiting is legitimate and it's the correct website in the cert. It makes sure the domain name of the server matches the cert.

 Since cloudfront is a shared service, the host machines behind cloudfront will be serving up all sorts of content and all sorts of SSL certs. So to get around this we have 2 options:
 1. pay for dedicated IP address for each edge location. This dedicated IP address will serve up our content and use just our cert
 2. We can use SNI (Service Name Indication) that allows the client to specify which host it's trying to connect to and the server can present multiple certs on the same IP. So the client is asking for the correct cert and the server, CloudFront is presenting it
   - the downside of using SNI is that a few old browsers don't support it (ex. Opera mobile for Symbian). All modern browsers should support SNI

## Security Policy
We can adjust what SSL/TLS version our CloudFront distribution supports by choosing a security policy
