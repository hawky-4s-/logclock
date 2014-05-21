%%%-------------------------------------------------------------------
%%% @author hawky4s
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. Mai 2014 16:45
%%%-------------------------------------------------------------------
-module(main).
-author("hawky4s").

%% API
-export([main/0]).

%% Macros
-define(NUM_OF_PROCESSES, 10).

-define(MAX_WAIT_TIME_IN_SECONDS, 3).
% CLOCK_BEHAVIOUR = 1 -> logical clock, 2 -> vector clock
-define(CLOCK_BEHAVIOUR, 1).


main() ->
  % start processes
  Processes = [ spawn(?MODULE, executeBehaviour, []) || _ <- lists:seq(1,?NUM_OF_PROCESSES) ],

  % send message with pids to all other processes so they know each other
  lists:foreach(
    fun(Pid) ->
      Pid ! { processes, [P || P <- Processes, P /= Pid] }
    end,
    Processes
  )




.



executeBehaviour({clock, ClockBehaviour, ClockIncrementValue, CurrentClockValue}, Receivers) ->

  initializeClock()

  receive
    {processes, Processes} ->
      Receivers = Processes,
    {From, ForeignClock} ->

  after (getRandomInteger(0, ?MAX_WAIT_TIME_IN_SECONDS) * 1000) ->
    % we send a message to another process
    io:format("Pid: ~p -> Hier könnte ihr Herzblatt stehen!~n", [self()]),
  end,

  exec
.


initializeClock() ->
  IncrementValue = getRandomInteger(0,self()),

  case ?CLOCK_BEHAVIOUR of
    1 ->
      ClockBehaviour = fun() -> logicalClock() end;
    2 ->
      ClockBehaviour = fun() -> vectorClock() end
  end

  {clock, MyBehaviour, MyIncrementValue, MyCurrentValue} =

.

% return
%   0 if clocks are equal
%   1 if first clock is smaller
%  -1 if second clock is smaller
compareClocks({Pid, LocalClock}, {From, ForeignClock}) ->
  if
    LocalClock < ForeignClock -> 1;
    LocalClock == ForeignClock andalso Pid < From -> -1;
    LocalClock == ForeignClock andalso Pid == From -> 0
  end
.


getRandomInteger(Min, Max) ->
  random:seed(erlang:now()),
  Min + random:uniform(Max - Min)
.


% kill all processes
kill(Processes) ->
  lists:foreach(fun(Pid) -> exit(Pid, kill) end, Processes)
.

%% logical clock (lamport clock)
%% each proess has its own clock
%% clock has custom increments
%% randomly send to random processes a message
%%   compare the local clock with the send value
%%   if local value > send value -> ok
%%   if local value < send value -> adjust the clock
%%   random timeout in seconds
%% maybe we can use the date function in combination with module to get the desired reuslt