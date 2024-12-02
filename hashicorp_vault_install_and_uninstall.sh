ldops02 ~ # docker inspect jfrog.test.net/plinfharbor/base-images/dotnet/sdk:6.0-focal
[
    {
        "Id": "sha256:188936c02d0e294a7b061460460ab3239a5d8f937e333394348465cc2ce30979",
        "RepoTags": [
            "jfrog.test.net/plinfharbor/base-images/dotnet/sdk:6.0-focal"
        ],
        "RepoDigests": [
            "jfrog.test.net/plinfharbor/base-images/dotnet/sdk@sha256:751bd030ed93d7c20db7043c2d0b0668fc283a30b7b441c3ff0592d364023081"
        ],
        "Parent": "",
        "Comment": "buildkit.dockerfile.v0",
        "Created": "2022-12-23T12:04:29.023485798Z",
        "DockerVersion": "",
        "Author": "",
        "Config": {
            "Hostname": "",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
                "ASPNETCORE_URLS=",
                "DOTNET_RUNNING_IN_CONTAINER=true",
                "DOTNET_VERSION=6.0.12",
                "ASPNET_VERSION=6.0.12",
                "DOTNET_GENERATE_ASPNET_CERTIFICATE=false",
                "DOTNET_NOLOGO=true",
                "DOTNET_SDK_VERSION=6.0.404",
                "DOTNET_USE_POLLING_FILE_WATCHER=true",
                "NUGET_XMLDOC_MODE=skip",
                "POWERSHELL_DISTRIBUTION_CHANNEL=PSDocker-DotnetSDK-Ubuntu-20.04",
                "ASPNETCORE_FORWARDEDHEADERS_ENABLED=true"
            ],
            "Cmd": [
                "/bin/bash"
            ],
            "Image": "",
            "Volumes": null,
            "WorkingDir": "",
            "Entrypoint": null,
            "OnBuild": null,
            "Labels": {
                "org.opencontainers.image.ref.name": "ubuntu",
                "org.opencontainers.image.version": "20.04"
            }
        },
        "Architecture": "amd64",
        "Os": "linux",
        "Size": 792776795,
        "GraphDriver": {
            "Data": {
                "LowerDir": "/var/lib/docker/overlay2/948aa7fa98dbacd6a72f31d8ac182bba5d0c1919ed372aa5472642e94bbfc3c0/diff:/var/lib/docker/overlay2/f7a8126f4ff41efe1dd4a85b0a825a6d6b722a8dc46ff43e14f4960829f2d7d9/diff:/var/lib/docker/overlay2/82bfd9e758b5c16c5620b243b4c78a8450e0d7c2104aafa2fee1b01c60356be3/diff:/var/lib/docker/overlay2/13cf0b419687ca55ca70992cebfe7c277041bf4fa0bdcc7ec2a20734da2e09f2/diff:/var/lib/docker/overlay2/b418a145fc6dea9d37816572b4f6f58386b8b4ead6b5c9a24cf13280b89d4f17/diff:/var/lib/docker/overlay2/0121363b4375b2cb15fb8965bac686adda673618d9aa6cfac2bdf147cf524f36/diff:/var/lib/docker/overlay2/e0c9cc8af8025c71bf4074c5227a3bde4851930400cb430de2f3a5b4fec3c8d2/diff:/var/lib/docker/overlay2/1fc31c15d56c939427fc0bf3d2a50a539951f67fef6e449f55be1c24505b7683/diff:/var/lib/docker/overlay2/31a8fa21de157e7714db179e8f7426d5b819dc8426b515bf077e77c63967a68d/diff:/var/lib/docker/overlay2/ebd325b511e838c4eb456334b87e374f21026276c725ce6ab8ecb6fb7d71c0d9/diff:/var/lib/docker/overlay2/b7db11949022daea3ab4d765f25d91bc814891f041e782a6ce032043a6ecf56b/diff",
                "MergedDir": "/var/lib/docker/overlay2/7c23b7426e9c4090be38919bc1447fa9c7dfedf3d34144b2c00b6b9898609b28/merged",
                "UpperDir": "/var/lib/docker/overlay2/7c23b7426e9c4090be38919bc1447fa9c7dfedf3d34144b2c00b6b9898609b28/diff",
                "WorkDir": "/var/lib/docker/overlay2/7c23b7426e9c4090be38919bc1447fa9c7dfedf3d34144b2c00b6b9898609b28/work"
            },
            "Name": "overlay2"
        },
        "RootFS": {
            "Type": "layers",
            "Layers": [
                "sha256:0002c93bdb3704dd9e36ce5153ef637f84de253015f3ee330468dccdeacad60b",
                "sha256:efd216112c85a9fdc27390cc712e2cd39155caf408519925a634d1315b7dcd7a",
                "sha256:97974c223bd43793f09af76fecaea47c307af36e296e5c19455ab2781376d881",
                "sha256:ff7316d0ba57f12a3c07a357e59611987f6f38dfce2c26f1dbe75ee71e8d9722",
                "sha256:43c1be86296878ac421fb7e615ee39ec0568d0f639b7626a26d1de92ae7fabd1",
                "sha256:18dd21935b9cf131f2fdd5ba38243c6fa654a665a124318b1f318c1d9eb55c9f",
                "sha256:474538158930daa54edd536b0d2b90efaf2e202a6e7f5426aca8ffc25b8ba513",
                "sha256:ec66a0a2015dd8611707e46b46f8346a8f456e55b3849de5597dd8dc949ae405",
                "sha256:2742e8b3f399b2c4b056d01102af5a26cdbc0bf18bd191af77088b82e4fb00c6",
                "sha256:cd5c892b9f0d439c64bc6f7d3222c8a67b4edc5bcdf615f40e613ea46abbd0cb",
                "sha256:6fa0575db7126571f853569072a6b6e1322eabca8319c390c7cfcfe2cdb342a7",
                "sha256:529fcb7cfe0bef58e601c5387fa3aa42b450f78ce0ebd5e4ab660c6424e3ddd0"
            ]
        },
        "Metadata": {
            "LastTagTime": "0001-01-01T00:00:00Z"
        }
    }
]
