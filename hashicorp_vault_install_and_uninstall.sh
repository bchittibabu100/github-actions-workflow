Unable to view workflow logs and here are the logs collected from selfhosted runner.

Under _diag Worker logs

[2025-07-17 22:47:44Z INFO TempDirectoryManager] Cleaning runner temp folder: /home/gitrunner/actions-runner/_work/_temp
[2025-07-17 22:47:44Z ERR  TempDirectoryManager] System.AggregateException: One or more errors occurred. (Access to the path '/home/gitrunner/actions-runner/_work/_temp/docker-actions-toolkit-fbDBfa' is denied.)
 ---> System.UnauthorizedAccessException: Access to the path '/home/gitrunner/actions-runner/_work/_temp/docker-actions-toolkit-fbDBfa' is denied.
 ---> System.IO.IOException: Permission denied
   --- End of inner exception stack trace ---
   at System.IO.Enumeration.FileSystemEnumerator`1.Init()
   at System.IO.Enumeration.FileSystemEnumerable`1..ctor(String directory, FindTransform transform, EnumerationOptions options, Boolean isNormalized)
   at System.IO.Enumeration.FileSystemEnumerableFactory.FileSystemInfos(String directory, String expression, EnumerationOptions options, Boolean isNormalized)
   at System.IO.DirectoryInfo.InternalEnumerateInfos(String path, String searchPattern, SearchTarget searchTarget, EnumerationOptions options)
   at System.IO.DirectoryInfo.GetFileSystemInfos(String searchPattern, EnumerationOptions enumerationOptions)
   at GitHub.Runner.Sdk.IOUtil.Enumerate(DirectoryInfo directory, CancellationTokenSource tokenSource)+MoveNext()
   at System.Linq.Parallel.PartitionedDataSource`1.ContiguousChunkLazyEnumerator.MoveNext(T& currentElement, Int32& currentKey)
   at System.Linq.Parallel.ForAllOperator`1.ForAllEnumerator`1.MoveNext(TInput& currentElement, Int32& currentKey)
   at System.Linq.Parallel.ForAllSpoolingTask`2.SpoolingWork()
   at System.Linq.Parallel.SpoolingTaskBase.Work()
   at System.Linq.Parallel.QueryTask.BaseWork(Object unused)
   at System.Threading.ExecutionContext.RunFromThreadPoolDispatchLoop(Thread threadPoolThread, ExecutionContext executionContext, ContextCallback callback, Object state)
--- End of stack trace from previous location ---
   at System.Threading.ExecutionContext.RunFromThreadPoolDispatchLoop(Thread threadPoolThread, ExecutionContext executionContext, ContextCallback callback, Object state)
   at System.Threading.Tasks.Task.ExecuteWithThreadLocal(Task& currentTaskSlot, Thread threadPoolThread)
   --- End of inner exception stack trace ---
   at System.Linq.Parallel.QueryTaskGroupState.QueryEnd(Boolean userInitiatedDispose)
   at System.Linq.Parallel.SpoolingTask.SpoolForAll[TInputOutput,TIgnoreKey](QueryTaskGroupState groupState, PartitionedStream`2 partitions, TaskScheduler taskScheduler)
   at System.Linq.Parallel.DefaultMergeHelper`2.System.Linq.Parallel.IMergeHelper<TInputOutput>.Execute()
   at System.Linq.Parallel.MergeExecutor`1.Execute()
   at System.Linq.Parallel.MergeExecutor`1.Execute[TKey](PartitionedStream`2 partitions, Boolean ignoreOutput, ParallelMergeOptions options, TaskScheduler taskScheduler, Boolean isOrdered, CancellationState cancellationState, Int32 queryId)
   at System.Linq.Parallel.PartitionedStreamMerger`1.Receive[TKey](PartitionedStream`2 partitionedStream)
   at System.Linq.Parallel.ForAllOperator`1.WrapPartitionedStream[TKey](PartitionedStream`2 inputStream, IPartitionedStreamRecipient`1 recipient, Boolean preferStriping, QuerySettings settings)
   at System.Linq.Parallel.UnaryQueryOperator`2.UnaryQueryOperatorResults.ChildResultsRecipient.Receive[TKey](PartitionedStream`2 inputStream)
   at System.Linq.Parallel.ScanQueryOperator`1.ScanEnumerableQueryOperatorResults.GivePartitionedStream(IPartitionedStreamRecipient`1 recipient)
   at System.Linq.Parallel.UnaryQueryOperator`2.UnaryQueryOperatorResults.GivePartitionedStream(IPartitionedStreamRecipient`1 recipient)
   at System.Linq.Parallel.QueryOperator`1.GetOpenedEnumerator(Nullable`1 mergeOptions, Boolean suppressOrder, Boolean forEffect, QuerySettings querySettings)
   at System.Linq.Parallel.ForAllOperator`1.RunSynchronously()
   at GitHub.Runner.Sdk.IOUtil.DeleteDirectory(String path, Boolean contentsOnly, Boolean continueOnContentDeleteError, CancellationToken cancellationToken)
   at GitHub.Runner.Worker.TempDirectoryManager.CleanupTempDirectory()

Under _diag Runner log:
[2025-07-18 02:32:20Z WARN GitHubActionsService] GET request to https://broker.actions.githubusercontent.com/message?sessionId=2153ac97-1722-42cc-9383-0e88ea6ad1a4&status=Busy&runnerVersion=2.326.0&os=Linux&architecture=X64&disableUpdate=false has been cancelled.
[2025-07-18 02:32:20Z ERR  BrokerServer] Catch exception during request
[2025-07-18 02:32:20Z ERR  BrokerServer] System.Threading.Tasks.TaskCanceledException: The operation was canceled.
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
[2025-07-18 02:32:20Z ERR  BrokerServer] #####################################################
[2025-07-18 02:32:20Z ERR  BrokerServer] System.Threading.Tasks.TaskCanceledException: The operation was canceled.
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
[2025-07-18 02:32:20Z ERR  BrokerServer] #####################################################
[2025-07-18 02:32:20Z ERR  BrokerServer] System.IO.IOException: Unable to read data from the transport connection: Operation canceled.
 ---> System.Net.Sockets.SocketException (125): Operation canceled
   --- End of inner exception stack trace ---
   at System.Net.Sockets.Socket.AwaitableSocketAsyncEventArgs.ThrowException(SocketError error, CancellationToken cancellationToken)
   at System.Net.Sockets.Socket.AwaitableSocketAsyncEventArgs.System.Threading.Tasks.Sources.IValueTaskSource<System.Int32>.GetResult(Int16 token)
   at System.Net.Security.SslStream.EnsureFullTlsFrameAsync[TIOAdapter](CancellationToken cancellationToken, Int32 estimatedSize)
   at System.Runtime.CompilerServices.PoolingAsyncValueTaskMethodBuilder`1.StateMachineBox`1.System.Threading.Tasks.Sources.IValueTaskSource<TResult>.GetResult(Int16 token)
   at System.Net.Security.SslStream.ReadAsyncInternal[TIOAdapter](Memory`1 buffer, CancellationToken cancellationToken)
   at System.Runtime.CompilerServices.PoolingAsyncValueTaskMethodBuilder`1.StateMachineBox`1.System.Threading.Tasks.Sources.IValueTaskSource<TResult>.GetResult(Int16 token)
   at System.Net.Http.HttpConnection.SendAsync(HttpRequestMessage request, Boolean async, CancellationToken cancellationToken)
[2025-07-18 02:32:20Z ERR  BrokerServer] #####################################################
[2025-07-18 02:32:20Z ERR  BrokerServer] System.Net.Sockets.SocketException (125): Operation canceled
[2025-07-18 02:32:20Z WARN BrokerServer] Back off 6.075 seconds before next retry. 4 attempt left.
[2025-07-18 02:32:20Z INFO BrokerMessageListener] Get messages has been cancelled using local token source. Continue to get messages with new status.
[2025-07-18 02:39:51Z INFO RSAFileKeyManager] Loading RSA key parameters from file /home/gitrunner/actions-runner/.credentials_rsaparams
[2025-07-18 02:39:51Z INFO GitHubActionsService] AAD Correlation ID for this token request: Unknown
