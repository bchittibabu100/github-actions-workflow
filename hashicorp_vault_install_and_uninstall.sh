╰─ jq '.runs[0].tool.driver.rules[] ' mep_xray.json | head -30                                                                                                          ─╯
{
  "id": "CVE-2024-6119_ubuntu:jammy:openssl_3.0.2-0ubuntu1.15",
  "shortDescription": {
    "text": "[CVE-2024-6119] ubuntu:jammy:openssl 3.0.2-0ubuntu1.15"
  },
  "help": {
    "text": "Issue summary: Applications performing certificate name checks (e.g., TLS\nclients checking server certificates) may attempt to read an invalid memory\naddress resulting in abnormal termination of the application process.\n\nImpact summary: Abnormal termination of an application can a cause a denial of\nservice.\n\nApplications performing certificate name checks (e.g., TLS clients checking\nserver certificates) may attempt to read an invalid memory address when\ncomparing the expected name with an `otherName` subject alternative name of an\nX.509 certificate. This may result in an exception that terminates the\napplication program.\n\nNote that basic certificate chain validation (signatures, dates, ...) is not\naffected, the denial of service can occur only when the application also\nspecifies an expected DNS name, Email address or IP address.\n\nTLS servers rarely solicit client certificates, and even when they do, they\ngenerally don't perform a name check against a reference identifier (expected\nidentity), but rather extract the presented identity after checking the\ncertificate chain.  So TLS servers are generally not affected and the severity\nof the issue is Moderate.\n\nThe FIPS modules in 3.3, 3.2, 3.1 and 3.0 are not affected by this issue.",
    "markdown": "| Severity Score | Direct Dependencies | Fixed Versions     |\n| :---:        |    :----:   |          :---: |\n| 0.0      | `sha256__e03118af76ff2a3972e19d97a30e987948864526c05b8e3a0ebc9019d9156f5b.tar `       | [3.0.2-0ubuntu1.18]   |"
  },
  "properties": {
    "security-severity": "0.0"
  }
}
{
  "id": "CVE-2024-33602_ubuntu:jammy:libc-bin_2.35-0ubuntu3.7",
  "shortDescription": {
    "text": "[CVE-2024-33602] ubuntu:jammy:libc-bin 2.35-0ubuntu3.7"
  },
  "help": {
    "text": "nscd: netgroup cache assumes NSS callback uses in-buffer strings\n\nThe Name Service Cache Daemon's (nscd) netgroup cache can corrupt memory\nwhen the NSS callback does not store all strings in the provided buffer.\nThe flaw was introduced in glibc 2.15 when the cache was added to nscd.\n\nThis vulnerability is only present in the nscd binary.\n\n",
    "markdown": "| Severity Score | Direct Dependencies | Fixed Versions     |\n| :---:        |    :----:   |          :---: |\n| 0.0      | `sha256__629ca62fb7c791374ce57626d6b8b62c76378be091a0daf1a60d32700b49add7.tar `       | No fix available   |"
  },
  "properties": {
    "security-severity": "0.0"
  }
}
{
  "id": "CVE-2024-37371_ubuntu:jammy:libgssapi-krb5-2_1.19.2-2ubuntu0.3",
  "shortDescription": {
    "text": "[CVE-2024-37371] ubuntu:jammy:libgssapi-krb5-2 1.19.2-2ubuntu0.3"
