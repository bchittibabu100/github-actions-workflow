2024-12-02T21:25:05-06:00       INFO    [vuln] Vulnerability scanning is enabled
2024-12-02T21:25:05-06:00	INFO	[secret] Secret scanning is enabled
2024-12-02T21:25:05-06:00	INFO	[secret] If your scanning is slow, please try '--scanners vuln' to disable secret scanning
2024-12-02T21:25:05-06:00	INFO	[secret] Please see also https://aquasecurity.github.io/trivy/v0.57/docs/scanner/secret#recommendation for faster secret detection
2024-12-02T21:25:12-06:00	INFO	Detected OS	family="ubuntu" version="24.04"
2024-12-02T21:25:12-06:00	INFO	[ubuntu] Detecting vulnerabilities...	os_version="24.04" pkg_num=113
2024-12-02T21:25:12-06:00	INFO	Number of language-specific files	num=19
2024-12-02T21:25:12-06:00	INFO	[dotnet-core] Detecting vulnerabilities...

ubuntu-sdk:8.0-focal (ubuntu 24.04)

Total: 16 (UNKNOWN: 0, LOW: 7, MEDIUM: 9, HIGH: 0, CRITICAL: 0)

┌────────────────────┬────────────────┬──────────┬──────────┬───────────────────┬───────────────┬──────────────────────────────────────────────────────────────┐
│      Library       │ Vulnerability  │ Severity │  Status  │ Installed Version │ Fixed Version │                            Title                             │
├────────────────────┼────────────────┼──────────┼──────────┼───────────────────┼───────────────┼──────────────────────────────────────────────────────────────┤
│ coreutils          │ CVE-2016-2781  │ LOW      │ affected │ 9.4-3ubuntu6      │               │ coreutils: Non-privileged session can escape to the parent   │
│                    │                │          │          │                   │               │ session in chroot                                            │
│                    │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2016-2781                    │
├────────────────────┼────────────────┤          │          ├───────────────────┼───────────────┼──────────────────────────────────────────────────────────────┤
│ gpgv               │ CVE-2022-3219  │          │          │ 2.4.4-2ubuntu17   │               │ gnupg: denial of service issue (resource consumption) using  │
│                    │                │          │          │                   │               │ compressed packets                                           │
│                    │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2022-3219                    │
├────────────────────┼────────────────┤          │          ├───────────────────┼───────────────┼──────────────────────────────────────────────────────────────┤
│ libc-bin           │ CVE-2016-20013 │          │          │ 2.39-0ubuntu8.3   │               │ sha256crypt and sha512crypt through 0.6 allow attackers to   │
│                    │                │          │          │                   │               │ cause a denial of...                                         │
│                    │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2016-20013                   │
├────────────────────┤                │          │          │                   ├───────────────┤                                                              │
│ libc6              │                │          │          │                   │               │                                                              │
│                    │                │          │          │                   │               │                                                              │
│                    │                │          │          │                   │               │                                                              │
├────────────────────┼────────────────┤          │          ├───────────────────┼───────────────┼──────────────────────────────────────────────────────────────┤
│ libgcrypt20        │ CVE-2024-2236  │          │          │ 1.10.3-2build1    │               │ libgcrypt: vulnerable to Marvin Attack                       │
│                    │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2024-2236                    │
├────────────────────┼────────────────┼──────────┤          ├───────────────────┼───────────────┼──────────────────────────────────────────────────────────────┤
│ libpam-modules     │ CVE-2024-10041 │ MEDIUM   │          │ 1.5.3-5ubuntu5.1  │               │ pam: libpam: Libpam vulnerable to read hashed password       │
│                    │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2024-10041                   │
│                    ├────────────────┤          │          │                   ├───────────────┼──────────────────────────────────────────────────────────────┤
│                    │ CVE-2024-10963 │          │          │                   │               │ pam: Improper Hostname Interpretation in pam_access Leads to │
│                    │                │          │          │                   │               │ Access Control Bypass                                        │
│                    │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2024-10963                   │
├────────────────────┼────────────────┤          │          │                   ├───────────────┼──────────────────────────────────────────────────────────────┤
│ libpam-modules-bin │ CVE-2024-10041 │          │          │                   │               │ pam: libpam: Libpam vulnerable to read hashed password       │
│                    │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2024-10041                   │
│                    ├────────────────┤          │          │                   ├───────────────┼──────────────────────────────────────────────────────────────┤
│                    │ CVE-2024-10963 │          │          │                   │               │ pam: Improper Hostname Interpretation in pam_access Leads to │
│                    │                │          │          │                   │               │ Access Control Bypass                                        │
│                    │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2024-10963                   │
├────────────────────┼────────────────┤          │          │                   ├───────────────┼──────────────────────────────────────────────────────────────┤
│ libpam-runtime     │ CVE-2024-10041 │          │          │                   │               │ pam: libpam: Libpam vulnerable to read hashed password       │
│                    │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2024-10041                   │
│                    ├────────────────┤          │          │                   ├───────────────┼──────────────────────────────────────────────────────────────┤
│                    │ CVE-2024-10963 │          │          │                   │               │ pam: Improper Hostname Interpretation in pam_access Leads to │
│                    │                │          │          │                   │               │ Access Control Bypass                                        │
│                    │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2024-10963                   │
├────────────────────┼────────────────┤          │          │                   ├───────────────┼──────────────────────────────────────────────────────────────┤
│ libpam0g           │ CVE-2024-10041 │          │          │                   │               │ pam: libpam: Libpam vulnerable to read hashed password       │
│                    │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2024-10041                   │
│                    ├────────────────┤          │          │                   ├───────────────┼──────────────────────────────────────────────────────────────┤
│                    │ CVE-2024-10963 │          │          │                   │               │ pam: Improper Hostname Interpretation in pam_access Leads to │
│                    │                │          │          │                   │               │ Access Control Bypass                                        │
│                    │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2024-10963                   │
├────────────────────┼────────────────┼──────────┤          ├───────────────────┼───────────────┼──────────────────────────────────────────────────────────────┤
│ libssl3t64         │ CVE-2024-41996 │ LOW      │          │ 3.0.13-0ubuntu3.4 │               │ openssl: remote attackers (from the client side) to trigger  │
│                    │                │          │          │                   │               │ unnecessarily expensive server-side...                       │
│                    │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2024-41996                   │
├────────────────────┤                │          │          │                   ├───────────────┤                                                              │
│ openssl            │                │          │          │                   │               │                                                              │
│                    │                │          │          │                   │               │                                                              │
│                    │                │          │          │                   │               │                                                              │
├────────────────────┼────────────────┼──────────┤          ├───────────────────┼───────────────┼──────────────────────────────────────────────────────────────┤
│ wget               │ CVE-2021-31879 │ MEDIUM   │          │ 1.21.4-1ubuntu4.1 │               │ wget: authorization header disclosure on redirect            │
│                    │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2021-31879                   │
└────────────────────┴────────────────┴──────────┴──────────┴───────────────────┴───────────────┴──────────────────────────────────────────────────────────────┘

usr/lib/dotnet/sdk/8.0.110/Containers/tasks/net8.0/Microsoft.NET.Build.Containers.deps.json (dotnet-core)

Total: 1 (UNKNOWN: 0, LOW: 0, MEDIUM: 0, HIGH: 0, CRITICAL: 1)

┌─────────────────┬───────────────┬──────────┬────────┬───────────────────┬──────────────────────────────────────────────────┬────────────────────────────────────────────────────────────┐
│     Library     │ Vulnerability │ Severity │ Status │ Installed Version │                  Fixed Version                   │                           Title                            │
├─────────────────┼───────────────┼──────────┼────────┼───────────────────┼──────────────────────────────────────────────────┼────────────────────────────────────────────────────────────┤
│ NuGet.Packaging │ CVE-2024-0057 │ CRITICAL │ fixed  │ 6.8.1-rc.32767    │ 5.11.6, 6.0.6, 6.3.4, 6.4.3, 6.6.2, 6.7.1, 6.8.1 │ dotnet: X509 Certificates - Validation Bypass across Azure │
│                 │               │          │        │                   │                                                  │ https://avd.aquasec.com/nvd/cve-2024-0057                  │
└─────────────────┴───────────────┴──────────┴────────┴───────────────────┴──────────────────────────────────────────────────┴────────────────────────────────────────────────────────────┘

usr/lib/dotnet/sdk/8.0.110/MSBuild.deps.json (dotnet-core)

Total: 1 (UNKNOWN: 0, LOW: 0, MEDIUM: 0, HIGH: 0, CRITICAL: 1)

┌─────────────────┬───────────────┬──────────┬────────┬───────────────────┬──────────────────────────────────────────────────┬────────────────────────────────────────────────────────────┐
│     Library     │ Vulnerability │ Severity │ Status │ Installed Version │                  Fixed Version                   │                           Title                            │
  1 FROM ubuntu:24.04
├─────────────────┼───────────────┼──────────┼────────┼───────────────────┼──────────────────────────────────────────────────┼────────────────────────────────────────────────────────────┤
│ NuGet.Packaging │ CVE-2024-0057 │ CRITICAL │ fixed  │ 6.8.1-rc.32767    │ 5.11.6, 6.0.6, 6.3.4, 6.4.3, 6.6.2, 6.7.1, 6.8.1 │ dotnet: X509 Certificates - Validation Bypass across Azure │
│                 │               │          │        │                   │                                                  │ https://avd.aquasec.com/nvd/cve-2024-0057                  │
└─────────────────┴───────────────┴──────────┴────────┴───────────────────┴──────────────────────────────────────────────────┴────────────────────────────────────────────────────────────┘

usr/lib/dotnet/sdk/8.0.110/NuGet.CommandLine.XPlat.deps.json (dotnet-core)

Total: 1 (UNKNOWN: 0, LOW: 0, MEDIUM: 0, HIGH: 0, CRITICAL: 1)

┌─────────────────┬───────────────┬──────────┬────────┬───────────────────┬──────────────────────────────────────────────────┬────────────────────────────────────────────────────────────┐
│     Library     │ Vulnerability │ Severity │ Status │ Installed Version │                  Fixed Version                   │                           Title                            │
├─────────────────┼───────────────┼──────────┼────────┼───────────────────┼──────────────────────────────────────────────────┼────────────────────────────────────────────────────────────┤
│ NuGet.Packaging │ CVE-2024-0057 │ CRITICAL │ fixed  │ 6.8.1-rc.32767    │ 5.11.6, 6.0.6, 6.3.4, 6.4.3, 6.6.2, 6.7.1, 6.8.1 │ dotnet: X509 Certificates - Validation Bypass across Azure │
│                 │               │          │        │                   │                                                  │ https://avd.aquasec.com/nvd/cve-2024-0057                  │
└─────────────────┴───────────────┴──────────┴────────┴───────────────────┴──────────────────────────────────────────────────┴────────────────────────────────────────────────────────────┘

usr/lib/dotnet/sdk/8.0.110/dotnet.deps.json (dotnet-core)

Total: 1 (UNKNOWN: 0, LOW: 0, MEDIUM: 0, HIGH: 0, CRITICAL: 1)

┌─────────────────┬───────────────┬──────────┬────────┬───────────────────┬──────────────────────────────────────────────────┬────────────────────────────────────────────────────────────┐
│     Library     │ Vulnerability │ Severity │ Status │ Installed Version │                  Fixed Version                   │                           Title                            │
├─────────────────┼───────────────┼──────────┼────────┼───────────────────┼──────────────────────────────────────────────────┼────────────────────────────────────────────────────────────┤
│ NuGet.Packaging │ CVE-2024-0057 │ CRITICAL │ fixed  │ 6.8.1-rc.32767    │ 5.11.6, 6.0.6, 6.3.4, 6.4.3, 6.6.2, 6.7.1, 6.8.1 │ dotnet: X509 Certificates - Validation Bypass across Azure │
│                 │               │          │        │                   │                                                  │ https://avd.aquasec.com/nvd/cve-2024-0057                  │
