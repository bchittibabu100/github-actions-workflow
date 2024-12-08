            this.GitRevision = System.Environment.GetEnvironmentVariable("RELEASE_COMMIT_SHA") ?? "[[GitRevision]]";
            this.BuildTime = System.Environment.GetEnvironmentVariable("IMAGE_BUILD_TIME") ?? "[[BuildTime]]";
            this.Environment = System.Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT");
            this.VersionInfo = System.Environment.GetEnvironmentVariable("RELEASE_TAG") ?? "[[VersionInfo]]";
            this.DataCenter = System.Environment.GetEnvironmentVariable("DEPLOYMENT_DATACENTER") ?? "[[DataCenter]]";
