[2025-07-23 02:32:09Z INFO JobDispatcher] Start renew job request 0 for job e5f216c1-7ded-5e5d-b721-52490562157d.
[2025-07-23 02:32:09Z INFO JobDispatcher] Successfully renew job e5f216c1-7ded-5e5d-b721-52490562157d, job is valid till 7/23/2025 2:42:09 AM
[2025-07-23 02:32:09Z INFO HostContext] Well known directory 'Bin': '/home/gitrunner/actions-runner/bin.2.326.0'
[2025-07-23 02:32:09Z INFO ProcessInvokerWrapper] Starting process:
[2025-07-23 02:32:09Z INFO ProcessInvokerWrapper]   File name: '/home/gitrunner/actions-runner/bin.2.326.0/Runner.Worker'
[2025-07-23 02:32:09Z INFO ProcessInvokerWrapper]   Arguments: 'spawnclient 155 158'
[2025-07-23 02:32:09Z INFO ProcessInvokerWrapper]   Working directory: '/home/gitrunner/actions-runner/bin.2.326.0'
[2025-07-23 02:32:09Z INFO ProcessInvokerWrapper]   Require exit code zero: 'False'
[2025-07-23 02:32:09Z INFO ProcessInvokerWrapper]   Encoding web name:  ; code page: ''
[2025-07-23 02:32:09Z INFO ProcessInvokerWrapper]   Force kill process on cancellation: 'True'
[2025-07-23 02:32:09Z INFO ProcessInvokerWrapper]   Redirected STDIN: 'False'
[2025-07-23 02:32:09Z INFO ProcessInvokerWrapper]   Persist current code page: 'False'
[2025-07-23 02:32:09Z INFO ProcessInvokerWrapper]   Keep redirected STDIN open: 'False'
[2025-07-23 02:32:09Z INFO ProcessInvokerWrapper]   High priority process: 'True'
[2025-07-23 02:32:09Z INFO ProcessInvokerWrapper] Process started with process id 1108603, waiting for process exit.
[2025-07-23 02:32:09Z INFO JobDispatcher] Send job request message to worker for job e5f216c1-7ded-5e5d-b721-52490562157d.
[2025-07-23 02:32:09Z INFO ProcessChannel] Sending message of length 30199, with hash 'bca6c6e0561734c939e0d7e611f8aa658d33f448e837e4fe8325bcdfd6ff725e'
[2025-07-23 02:32:09Z INFO JobNotification] Entering JobStarted Notification
[2025-07-23 02:32:09Z INFO JobNotification] Entering StartMonitor
[2025-07-23 02:33:09Z INFO JobDispatcher] Successfully renew job e5f216c1-7ded-5e5d-b721-52490562157d, job is valid till 7/23/2025 2:43:09 AM
[2025-07-23 02:34:10Z INFO JobDispatcher] Successfully renew job e5f216c1-7ded-5e5d-b721-52490562157d, job is valid till 7/23/2025 2:44:10 AM
[2025-07-23 02:35:10Z INFO JobDispatcher] Successfully renew job e5f216c1-7ded-5e5d-b721-52490562157d, job is valid till 7/23/2025 2:45:10 AM
[2025-07-23 02:36:10Z INFO JobDispatcher] Successfully renew job e5f216c1-7ded-5e5d-b721-52490562157d, job is valid till 7/23/2025 2:46:10 AM
[2025-07-23 02:37:10Z INFO JobDispatcher] Successfully renew job e5f216c1-7ded-5e5d-b721-52490562157d, job is valid till 7/23/2025 2:47:10 AM
[2025-07-23 02:38:05Z INFO ProcessInvokerWrapper] STDOUT/STDERR stream read finished.
[2025-07-23 02:38:05Z INFO ProcessInvokerWrapper] STDOUT/STDERR stream read finished.
[2025-07-23 02:38:05Z INFO ProcessInvokerWrapper] Finished process 1108603 with exit code 100, and elapsed time 00:05:55.9134266.
[2025-07-23 02:38:05Z INFO JobDispatcher] Worker finished for job e5f216c1-7ded-5e5d-b721-52490562157d. Code: 100
[2025-07-23 02:38:05Z INFO JobDispatcher] finish job request for job e5f216c1-7ded-5e5d-b721-52490562157d with result: Succeeded
[2025-07-23 02:38:05Z INFO Terminal] WRITE LINE: 2025-07-23 02:38:05Z: Job call-build-and-deploy / build-and-deploy completed with result: Succeeded
[2025-07-23 02:38:05Z INFO JobDispatcher] Stop renew job request for job e5f216c1-7ded-5e5d-b721-52490562157d.
[2025-07-23 02:38:05Z INFO JobDispatcher] job renew has been cancelled, stop renew job e5f216c1-7ded-5e5d-b721-52490562157d.
[2025-07-23 02:38:05Z INFO JobNotification] Entering JobCompleted Notification
[2025-07-23 02:38:05Z INFO JobNotification] Entering EndMonitor
[2025-07-23 02:38:05Z INFO BrokerMessageListener] Received job status event. JobState: Online
[2025-07-23 02:38:05Z WARN GitHubActionsService] GET request to https://broker.actions.githubusercontent.com/message?sessionId=b9dc0266-e5a3-4b9a-8dff-69f1cd000a5a&status=Busy&runnerVersion=2.326.0&os=Linux&architecture=X64&disableUpdate=false has been cancelled.
[2025-07-23 02:38:05Z ERR  BrokerServer] Catch exception during request
[2025-07-23 02:38:05Z ERR  BrokerServer] System.Threading.Tasks.TaskCanceledException: The operation was canceled.
 ---> System.Threading.Tasks.TaskCanceledException: The operation was canceled.
 ---> System.IO.IOException: Unable to read data from the transport connection: Operation canceled.
 ---> System.Net.Sockets.SocketException (125): Operation canceled
   --- End of inner exception stack trace ---
   at System.Net.Sockets.Socket.AwaitableSocketAsyncEventArgs.ThrowException(SocketError error, CancellationToken cancellationToken)
   at System.Net.Sockets.Socket.AwaitableSocketAsyncEventArgs.System.Threading.Tasks.Sources.IValueTaskSource<System.Int32>.GetResult(Int16 token)
   at System.Net.Security.SslStream.EnsureFullTlsFrameAsync[TIOAdapter](CancellationToken cancellationToken, Int32 estimatedSize)
   at System.Runtime.CompilerServices.PoolingAsyncValueTaskMethodBuilder`1.StateMachineBox`1.System.Threading.Tasks.Sources.IValueTaskSource<TResult>.GetResult(Int16 token)
   at System.Net.Security.SslStream.ReadAsyncInternal[TIOAdapter](Memory`1 buffer, CancellationToken cancellationToken)
   at System.Runtime.CompilerServices.PoolingAsyncValueTaskMethodBuilder`1.StateMachineBox`1.System.Threading.Tasks.Sources.IValueTaskSource<TResult>.GetResult(Int16 token)
   at System.Net.Http.HttpConnection.SendAsync(HttpRequestMessage request, Boolean async, CancellationToken cancellationToken)
   --- End of inner exception stack trace ---
   at System.Net.Http.HttpConnection.SendAsync(HttpRequestMessage request, Boolean async, CancellationToken cancellationToken)
   at System.Net.Http.AuthenticationHelper.SendWithNtAuthAsync(HttpRequestMessage request, Uri authUri, Boolean async, ICredentials credentials, Boolean isProxyAuth, HttpConnection connection, HttpConnectionPool connectionPool, CancellationToken cancellationToken)
   at System.Net.Http.HttpConnectionPool.SendWithVersionDetectionAndRetryAsync(HttpRequestMessage request, Boolean async, Boolean doRequestAuth, CancellationToken cancellationToken)
   at System.Net.Http.AuthenticationHelper.SendWithAuthAsync(HttpRequestMessage request, Uri authUri, Boolean async, ICredentials credentials, Boolean preAuthenticate, Boolean isProxyAuth, Boolean doRequestAuth, HttpConnectionPool pool, CancellationToken cancellationToken)
   at System.Net.Http.RedirectHandler.SendAsync(HttpRequestMessage request, Boolean async, CancellationToken cancellationToken)
   at GitHub.Services.Common.RawHttpMessageHandler.SendAsync(HttpRequestMessage request, CancellationToken cancellationToken)
   at GitHub.Services.Common.VssHttpRetryMessageHandler.SendAsync(HttpRequestMessage request, CancellationToken cancellationToken)
   at System.Net.Http.HttpClient.<SendAsync>g__Core|83_0(HttpRequestMessage request, HttpCompletionOption completionOption, CancellationTokenSource cts, Boolean disposeCts, CancellationTokenSource pendingRequestsCts, CancellationToken originalCancellationToken)
   --- End of inner exception stack trace ---
   at System.Net.Http.HttpClient.HandleFailure(Exception e, Boolean telemetryStarted, HttpResponseMessage response, CancellationTokenSource cts, CancellationToken cancellationToken, CancellationTokenSource pendingRequestsCts)
   at System.Net.Http.HttpClient.<SendAsync>g__Core|83_0(HttpRequestMessage request, HttpCompletionOption completionOption, CancellationTokenSource cts, Boolean disposeCts, CancellationTokenSource pendingRequestsCts, CancellationToken originalCancellationToken)
   at Sdk.WebApi.WebApi.RawHttpClientBase.SendAsync(HttpRequestMessage message, HttpCompletionOption completionOption, Object userState, CancellationToken cancellationToken)
   at Sdk.WebApi.WebApi.RawHttpClientBase.SendAsync[T](HttpRequestMessage message, Boolean readErrorBody, Object userState, CancellationToken cancellationToken)
   at Sdk.WebApi.WebApi.RawHttpClientBase.SendAsync[T](HttpMethod method, IEnumerable`1 additionalHeaders, Uri requestUri, HttpContent content, IEnumerable`1 queryParameters, Boolean readErrorBody, Object userState, CancellationToken cancellationToken)
   at GitHub.Actions.RunService.WebApi.BrokerHttpClient.GetRunnerMessageAsync(Nullable`1 sessionId, String runnerVersion, Nullable`1 status, String os, String architecture, Nullable`1 disableUpdate, CancellationToken cancellationToken)
   at GitHub.Runner.Common.BrokerServer.<>c__DisplayClass7_0.<<GetRunnerMessageAsync>b__0>d.MoveNext()
--- End of stack trace from previous location ---
   at GitHub.Runner.Common.RunnerService.RetryRequest[T](Func`1 func, CancellationToken cancellationToken, Int32 maxRetryAttemptsCount, Func`2 shouldRetry)
[2025-07-23 02:38:05Z ERR  BrokerServer] #####################################################
[2025-07-23 02:38:05Z ERR  BrokerServer] System.Threading.Tasks.TaskCanceledException: The operation was canceled.
 ---> System.IO.IOException: Unable to read data from the transport connection: Operation canceled.
 ---> System.Net.Sockets.SocketException (125): Operation canceled
   --- End of inner exception stack trace ---
   at System.Net.Sockets.Socket.AwaitableSocketAsyncEventArgs.ThrowException(SocketError error, CancellationToken cancellationToken)
   at System.Net.Sockets.Socket.AwaitableSocketAsyncEventArgs.System.Threading.Tasks.Sources.IValueTaskSource<System.Int32>.GetResult(Int16 token)
   at System.Net.Security.SslStream.EnsureFullTlsFrameAsync[TIOAdapter](CancellationToken cancellationToken, Int32 estimatedSize)
   at System.Runtime.CompilerServices.PoolingAsyncValueTaskMethodBuilder`1.StateMachineBox`1.System.Threading.Tasks.Sources.IValueTaskSource<TResult>.GetResult(Int16 token)
   at System.Net.Security.SslStream.ReadAsyncInternal[TIOAdapter](Memory`1 buffer, CancellationToken cancellationToken)
   at System.Runtime.CompilerServices.PoolingAsyncValueTaskMethodBuilder`1.StateMachineBox`1.System.Threading.Tasks.Sources.IValueTaskSource<TResult>.GetResult(Int16 token)
   at System.Net.Http.HttpConnection.SendAsync(HttpRequestMessage request, Boolean async, CancellationToken cancellationToken)
   --- End of inner exception stack trace ---
   at System.Net.Http.HttpConnection.SendAsync(HttpRequestMessage request, Boolean async, CancellationToken cancellationToken)
   at System.Net.Http.AuthenticationHelper.SendWithNtAuthAsync(HttpRequestMessage request, Uri authUri, Boolean async, ICredentials credentials, Boolean isProxyAuth, HttpConnection connection, HttpConnectionPool connectionPool, CancellationToken cancellationToken)
   at System.Net.Http.HttpConnectionPool.SendWithVersionDetectionAndRetryAsync(HttpRequestMessage request, Boolean async, Boolean doRequestAuth, CancellationToken cancellationToken)
   at System.Net.Http.AuthenticationHelper.SendWithAuthAsync(HttpRequestMessage request, Uri authUri, Boolean async, ICredentials credentials, Boolean preAuthenticate, Boolean isProxyAuth, Boolean doRequestAuth, HttpConnectionPool pool, CancellationToken cancellationToken)
   at System.Net.Http.RedirectHandler.SendAsync(HttpRequestMessage request, Boolean async, CancellationToken cancellationToken)
   at GitHub.Services.Common.RawHttpMessageHandler.SendAsync(HttpRequestMessage request, CancellationToken cancellationToken)
   at GitHub.Services.Common.VssHttpRetryMessageHandler.SendAsync(HttpRequestMessage request, CancellationToken cancellationToken)
   at System.Net.Http.HttpClient.<SendAsync>g__Core|83_0(HttpRequestMessage request, HttpCompletionOption completionOption, CancellationTokenSource cts, Boolean disposeCts, CancellationTokenSource pendingRequestsCts, CancellationToken originalCancellationToken)
[2025-07-23 02:38:05Z ERR  BrokerServer] #####################################################
[2025-07-23 02:38:05Z ERR  BrokerServer] System.IO.IOException: Unable to read data from the transport connection: Operation canceled.
 ---> System.Net.Sockets.SocketException (125): Operation canceled
   --- End of inner exception stack trace ---
   at System.Net.Sockets.Socket.AwaitableSocketAsyncEventArgs.ThrowException(SocketError error, CancellationToken cancellationToken)
   at System.Net.Sockets.Socket.AwaitableSocketAsyncEventArgs.System.Threading.Tasks.Sources.IValueTaskSource<System.Int32>.GetResult(Int16 token)
   at System.Net.Security.SslStream.EnsureFullTlsFrameAsync[TIOAdapter](CancellationToken cancellationToken, Int32 estimatedSize)
   at System.Runtime.CompilerServices.PoolingAsyncValueTaskMethodBuilder`1.StateMachineBox`1.System.Threading.Tasks.Sources.IValueTaskSource<TResult>.GetResult(Int16 token)
   at System.Net.Security.SslStream.ReadAsyncInternal[TIOAdapter](Memory`1 buffer, CancellationToken cancellationToken)
   at System.Runtime.CompilerServices.PoolingAsyncValueTaskMethodBuilder`1.StateMachineBox`1.System.Threading.Tasks.Sources.IValueTaskSource<TResult>.GetResult(Int16 token)
   at System.Net.Http.HttpConnection.SendAsync(HttpRequestMessage request, Boolean async, CancellationToken cancellationToken)
[2025-07-23 02:38:05Z ERR  BrokerServer] #####################################################
[2025-07-23 02:38:05Z ERR  BrokerServer] System.Net.Sockets.SocketException (125): Operation canceled
[2025-07-23 02:38:05Z WARN BrokerServer] Back off 11.373 seconds before next retry. 4 attempt left.
[2025-07-23 02:38:05Z INFO BrokerMessageListener] Get messages has been cancelled using local token source. Continue to get messages with new status.
[2025-07-23 02:39:46Z INFO RSAFileKeyManager] Loading RSA key parameters from file /home/gitrunner/actions-runner/.credentials_rsaparams
[2025-07-23 02:39:46Z INFO GitHubActionsService] AAD Correlation ID for this token request: Unknown
[2025-07-23 03:29:51Z INFO RSAFileKeyManager] Loading RSA key parameters from file /home/gitrunner/actions-runner/.credentials_rsaparams
[2025-07-23 03:29:51Z INFO GitHubActionsService] AAD Correlation ID for this token request: Unknown
