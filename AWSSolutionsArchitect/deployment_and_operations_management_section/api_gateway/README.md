# API Gateway -> managed, high availability service to front-end REST APIs
- allows us to create RESTAPIs that are hosted and managed in a scalable fashion.
- Backed with custom code via Lambda, as a proxy for another AWS Service or any other HTTP API on AWS or elsewhere
- regionally based, private or edge optimized (deployed via CloudFront)
- supports API keys and usage plans for user identification, throttling or quota management. (use case: if selling API as a service we can implement throttling or quota management)
- using cloudfront behind the scenes and custom domains and SNI are supported
- can be published as products and monetized on AWS marketplace
- API Gateway can also cached responses
