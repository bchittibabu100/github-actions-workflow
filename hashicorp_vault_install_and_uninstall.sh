{
  "id": "CVE-2024-51501_refit_7.2.1",
  "shortDescription": {
    "text": "[CVE-2024-51501] refit 7.2.1"
  },
  "help": {
    "text": "Refit is an automatic type-safe REST library for .NET Core, Xamarin and .NET The various header-related Refit attributes (Header, HeaderCollection and Authorize) are vulnerable to CRLF injection. The way HTTP headers are added to a request is via the `HttpHeaders.TryAddWithoutValidation` method. This method does not check for CRLF characters in the header value. This means that any headers added to a refit request are vulnerable to CRLF-injection. In general, CRLF-injection into a HTTP header (when using HTTP/1.1) means that one can inject additional HTTP headers or smuggle whole HTTP requests. If an application using the Refit library passes a user-controllable value through to a header, then that application becomes vulnerable to CRLF-injection. This is not necessarily a security issue for a command line application like the one above, but if such code were present in a web application then it becomes vulnerable to request splitting (as shown in the PoC) and thus Server Side Request
    "markdown": "| Severity Score | Direct Dependencies | Fixed Versions     |\n| :---:        |    :----:   |          :---: |\n| 9.8      | `sha256__4110e4a8866f596ee3b4aea66c831f6ba5d5aad4060e17a3d4faaa5670b0f7d5.tar `       | [7.2.22]   |"
  },
  "properties": {
    "security-severity": "9.8"
  }
}
