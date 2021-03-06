-module(queuesk_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

%%===================================================================
%% API functions
%%===================================================================

%%--------------------------------------------------------------------
%% start_link
%%--------------------------------------------------------------------
start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%%===================================================================
%% Supervisor callbacks
%%===================================================================

%%--------------------------------------------------------------------
%% init
%%--------------------------------------------------------------------
init([]) ->
    QueueskPoolSup = {queuesk_pool_sup,
		      {queuesk_pool_sup, start_link, []},
		      permanent,
		      3000,
		      supervisor,
		      [queuesk_pool_sup]},
    
    QueueskManager = {queuesk_manager,
		      {queuesk_manager, start_link, []},
		      permanent,
		      3000,
		      worker,
		      [queuesk_manager]},
    
    {ok, {{one_for_all, 5, 10},
	  [QueueskPoolSup, QueueskManager]}}.

