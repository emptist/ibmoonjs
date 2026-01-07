///|
// IB TWS/Gateway API Wrapper for MoonBit
// This module provides a comprehensive interface to Interactive Brokers' API

///|
// Connection configuration
pub struct ConnectionConfig {
  host : String
  port : Int
  client_id : Int
  connect_options : ConnectOptions?
}

///|
pub fn default_connection_config() -> ConnectionConfig {
  { host: "127.0.0.1", port: 7497, client_id: 1, connect_options: None }
}

///|
pub fn connection_config(
  host : String,
  port : Int,
  client_id : Int,
  connect_options : ConnectOptions?,
) -> ConnectionConfig {
  { host, port, client_id, connect_options }
}

///|
pub struct ConnectOptions {
  read_only : Bool
  reconnect_attempts : Int
  reconnect_delay_ms : Int
}

///|
pub fn default_connect_options() -> ConnectOptions {
  { read_only: false, reconnect_attempts: 3, reconnect_delay_ms: 1000 }
}

///|
// Connection state
pub enum ConnectionState {
  Disconnected
  Connecting
  Connected
  Disconnecting
  Error(String)
}

///|
// Contract types
pub enum SecType {
  Stock
  Option
  Future
  Forex
  Bond
  CFD
  FutureOption
  MutualFund
  Warrant
  StructuredProduct
  Index
  Commodity
}

///|
pub fn sec_type_to_string(st : SecType) -> String {
  match st {
    Stock => "STK"
    Option => "OPT"
    Future => "FUT"
    Forex => "CASH"
    Bond => "BOND"
    CFD => "CFD"
    FutureOption => "FOP"
    MutualFund => "FUND"
    Warrant => "IOPT"
    StructuredProduct => "IKS"
    Index => "IND"
    Commodity => "CMDTY"
  }
}

///|
pub fn string_to_sec_type(s : String) -> SecType? {
  match s {
    "STK" => Some(Stock)
    "OPT" => Some(Option)
    "FUT" => Some(Future)
    "CASH" => Some(Forex)
    "BOND" => Some(Bond)
    "CFD" => Some(CFD)
    "FOP" => Some(FutureOption)
    "FUND" => Some(MutualFund)
    "IOPT" => Some(Warrant)
    "IKS" => Some(StructuredProduct)
    "IND" => Some(Index)
    "CMDTY" => Some(Commodity)
    _ => None
  }
}

///|
// Contract details
pub struct Contract {
  con_id : Int
  symbol : String
  sec_type : SecType
  last_trade_date_or_contract_month : String
  strike : Double
  right : String
  multiplier : String
  exchange : String
  primary_exchange : String
  currency : String
  local_symbol : String
  trading_class : String
  include_expired : Bool
  sec_id_type : String
  sec_id : String
}

///|
pub fn default_contract() -> Contract {
  {
    con_id: 0,
    symbol: "",
    sec_type: Stock,
    last_trade_date_or_contract_month: "",
    strike: 0.0,
    right: "",
    multiplier: "",
    exchange: "SMART",
    primary_exchange: "",
    currency: "USD",
    local_symbol: "",
    trading_class: "",
    include_expired: false,
    sec_id_type: "",
    sec_id: "",
  }
}

///|
// Order types
pub enum OrderType {
  Market
  Limit
  Stop
  StopLimit
  MarketOnClose
  LimitOnClose
  MarketOnOpen
  LimitOnOpen
  Trail
  TrailLimit
  Relative
  Pegged
}

///|
pub fn order_type_to_string(ot : OrderType) -> String {
  match ot {
    Market => "MKT"
    Limit => "LMT"
    Stop => "STP"
    StopLimit => "STP LMT"
    MarketOnClose => "MOC"
    LimitOnClose => "LOC"
    MarketOnOpen => "MOP"
    LimitOnOpen => "LOO"
    Trail => "TRAIL"
    TrailLimit => "TRAIL LIMIT"
    Relative => "REL"
    Pegged => "PEG"
  }
}

///|
// Time in force
pub enum TimeInForce {
  Day
  GTC
  OPG
  IOC
  FOK
  GTX
  GTD
}

///|
pub fn time_in_force_to_string(tif : TimeInForce) -> String {
  match tif {
    Day => "DAY"
    GTC => "GTC"
    OPG => "OPG"
    IOC => "IOC"
    FOK => "FOK"
    GTX => "GTX"
    GTD => "GTD"
  }
}

///|
// Order action
pub enum OrderAction {
  Buy
  Sell
  SSHORT
  SSHORTX
}

///|
pub fn order_action_to_string(oa : OrderAction) -> String {
  match oa {
    Buy => "BUY"
    Sell => "SELL"
    SSHORT => "SSHORT"
    SSHORTX => "SSHORTX"
  }
}

///|
// Order details
pub struct Order {
  order_id : Int
  client_id : Int
  action : OrderAction
  total_quantity : Double
  order_type : OrderType
  lmt_price : Double
  aux_price : Double
  time_in_force : TimeInForce
  oca_group : String
  oca_type : Int
  account : String
  open_close : String
  origin : Int
  transmit : Bool
  parent_id : Int
  block_order : Bool
  sweep_to_fill : Bool
  display_size : Int
  trigger_method : Int
  outside_rth : Bool
  hidden : Bool
  discretionary_amt : Double
  good_after_time : String
  good_till_date : String
  fa_group : String
  fa_method : String
  fa_percentage : String
  all_or_none : Bool
  min_qty : Int
  percent_offset : Double
  eTrade_only : Bool
  firm_quote_only : Bool
  nbbo_price_cap : Double
  opt_out_smart_routing : Bool
  scale_init_level_size : Int
  scale_subs_level_size : Int
  scale_price_increment : Double
  scale_price_adjust_value : Double
  scale_price_adjust_interval : Int
  scale_profit_offset : Double
  scale_auto_reset : Bool
  scale_init_position : Int
  scale_init_fill_qty : Int
  scale_random_percent : Bool
  hedge_type : String
  hedge_param : String
  algo_strategy : String
  algo_params : Array[(String, String)]
  smart_combo_routing_params : Array[(String, String)]
  what_if : Bool
  not_held : Bool
}

///|
pub fn default_order() -> Order {
  {
    order_id: 0,
    client_id: 0,
    action: Buy,
    total_quantity: 0.0,
    order_type: Market,
    lmt_price: 0.0,
    aux_price: 0.0,
    time_in_force: Day,
    oca_group: "",
    oca_type: 0,
    account: "",
    open_close: "O",
    origin: 0,
    transmit: true,
    parent_id: 0,
    block_order: false,
    sweep_to_fill: false,
    display_size: 0,
    trigger_method: 0,
    outside_rth: false,
    hidden: false,
    discretionary_amt: 0.0,
    good_after_time: "",
    good_till_date: "",
    fa_group: "",
    fa_method: "",
    fa_percentage: "",
    all_or_none: false,
    min_qty: 0,
    percent_offset: 0.0,
    eTrade_only: false,
    firm_quote_only: false,
    nbbo_price_cap: 0.0,
    opt_out_smart_routing: false,
    scale_init_level_size: 0,
    scale_subs_level_size: 0,
    scale_price_increment: 0.0,
    scale_price_adjust_value: 0.0,
    scale_price_adjust_interval: 0,
    scale_profit_offset: 0.0,
    scale_auto_reset: false,
    scale_init_position: 0,
    scale_init_fill_qty: 0,
    scale_random_percent: false,
    hedge_type: "",
    hedge_param: "",
    algo_strategy: "",
    algo_params: [],
    smart_combo_routing_params: [],
    what_if: false,
    not_held: false,
  }
}

///|
// Tick types
pub enum TickType {
  BidSize
  BidPrice
  AskPrice
  AskSize
  LastPrice
  LastSize
  High
  Low
  Volume
  Close
  BidOptionComputation
  AskOptionComputation
  LastOptionComputation
  ModelOption
  Open
  Low13Week
  High13Week
  Low26Week
  High26Week
  Low52Week
  High52Week
  AvgVolume
  OpenInterest
  OptionHistoricalVol
  OptionImpliedVol
  OptionBidExch
  OptionAskExch
  OptionCallOpenInterest
  OptionPutOpenInterest
  OptionCallVolume
  OptionPutVolume
  IndexFuturePremium
  BidExch
  AskExch
  AuctionVolume
  AuctionPrice
  AuctionImbalance
  MarkPrice
  BidEFPComputation
  AskEFPComputation
  LastEFPComputation
  OpenEFPComputation
  HighEFPComputation
  LowEFPComputation
  CloseEFPComputation
  LastTimestamp
  Shortable
  FundamentalRatios
  RTVolume
  HALTED
  BidYield
  AskYield
  LastYield
  CustOptionComputation
  TradeCount
  TradeRate
  VolumeRate
  LastRTHTrade
  RT_HistoricalVol
  IBDividends
  BondFactorMultipliers
  RT_TradeVolume
  RT_TradeRate
}

///|
// Tick data
pub struct TickData {
  tick_type : TickType
  price : Double
  size : Int
  timestamp : Int64
}

///|
// Market depth
pub struct MarketDepth {
  position : Int
  market_maker : String
  operation : Int
  side : Int
  price : Double
  size : Double
}

///|
// Order state
pub struct OrderState {
  status : String
  init_margin : String
  maint_margin : String
  equity_with_loan : String
  commission : Double
  min_commission : Double
  max_commission : Double
  commission_currency : String
  warning_text : String
}

///|
// Execution details
pub struct Execution {
  order_id : Int
  client_id : Int
  exec_id : String
  time : String
  account : String
  exchange : String
  side : String
  shares : Double
  price : Double
  perm_id : Int
  client_id_ref : Int
  order_ref : String
  ev_rule : String
  ev_multiplier : Double
  model_code : String
  last_liquidity : Int
}

///|
// Account summary
pub struct AccountSummary {
  account : String
  tag : String
  value : String
  currency : String
}

///|
// Portfolio item
pub struct PortfolioItem {
  account : String
  contract : Contract
  position : Double
  market_price : Double
  market_value : Double
  average_cost : Double
  unrealized_pnl : Double
  realized_pnl : String
  account_name : String
}

///|
// Historical data bar
pub enum BarSize {
  Sec1
  Sec5
  Sec15
  Sec30
  Min1
  Min2
  Min3
  Min5
  Min15
  Min30
  Hour1
  Day1
  Week1
  Month1
  Quarter1
  Year1
}

///|
pub fn bar_size_to_string(bs : BarSize) -> String {
  match bs {
    Sec1 => "1 secs"
    Sec5 => "5 secs"
    Sec15 => "15 secs"
    Sec30 => "30 secs"
    Min1 => "1 min"
    Min2 => "2 mins"
    Min3 => "3 mins"
    Min5 => "5 mins"
    Min15 => "15 mins"
    Min30 => "30 mins"
    Hour1 => "1 hour"
    Day1 => "1 day"
    Week1 => "1 week"
    Month1 => "1 month"
    Quarter1 => "1 quarter"
    Year1 => "1 year"
  }
}

///|
pub enum WhatToShow {
  Trades
  Midpoint
  Bid
  Ask
  BidAsk
  HistoricalVolatility
  OptionImpliedVolatility
  FeeRate
  AggregateVolume
}

///|
pub fn what_to_show_to_string(wts : WhatToShow) -> String {
  match wts {
    Trades => "TRADES"
    Midpoint => "MIDPOINT"
    Bid => "BID"
    Ask => "ASK"
    BidAsk => "BID_ASK"
    HistoricalVolatility => "HISTORICAL_VOLATILITY"
    OptionImpliedVolatility => "OPTION_IMPLIED_VOLATILITY"
    FeeRate => "FEE_RATE"
    AggregateVolume => "AGGREGATE_VOLUME"
  }
}

///|
// Historical data bar
pub struct HistoricalDataBar {
  date : String
  open : Double
  high : Double
  low : Double
  close : Double
  volume : Int
  bar_count : Int
  wap : Double
  has_gaps : Bool
}

///|
// Error codes
pub enum ErrorCode {
  NoError
  Unknown
  ConnectionRefused
  InvalidMessage
  ServerVersionNotSupported
  ClientAlreadyConnected
  ClientNotConnected
  InvalidConnectionId
  Unauthorized
  InvalidSymbol
  InvalidQuantity
  InvalidOrderType
  InvalidPrice
  InvalidTimeInForce
  InvalidExchange
  OrderRejected
  OrderCancelled
  UnknownError(Int)
}

///|
pub fn int_to_error_code(code : Int) -> ErrorCode {
  match code {
    0 => NoError
    502 => ConnectionRefused
    509 => ServerVersionNotSupported
    500 => ClientAlreadyConnected
    501 => ClientNotConnected
    506 => InvalidConnectionId
    507 => Unauthorized
    200 => InvalidSymbol
    201 => InvalidQuantity
    202 => InvalidOrderType
    203 => InvalidPrice
    204 => InvalidTimeInForce
    205 => InvalidExchange
    100 => OrderRejected
    202 => OrderCancelled
    _ => UnknownError(code)
  }
}

///|
pub fn error_code_to_string(ec : ErrorCode) -> String {
  match ec {
    NoError => "No error"
    Unknown => "Unknown error"
    ConnectionRefused => "Connection refused"
    InvalidMessage => "Invalid message"
    ServerVersionNotSupported => "Server version not supported"
    ClientAlreadyConnected => "Client already connected"
    ClientNotConnected => "Client not connected"
    InvalidConnectionId => "Invalid connection ID"
    Unauthorized => "Unauthorized"
    InvalidSymbol => "Invalid symbol"
    InvalidQuantity => "Invalid quantity"
    InvalidOrderType => "Invalid order type"
    InvalidPrice => "Invalid price"
    InvalidTimeInForce => "Invalid time in force"
    InvalidExchange => "Invalid exchange"
    OrderRejected => "Order rejected"
    OrderCancelled => "Order cancelled"
    UnknownError(code) => "Unknown error: " + code.to_string()
  }
}

///|
// High-level API wrapper for IB TWS/Gateway
// Provides a simplified, user-friendly interface for common operations

///|
pub struct IBApi {
  client : Client
}

///|
pub enum ApiError {
  ClientError(String)
  InvalidState(String)
  Timeout
  NotFound
}

///|
// Create a new IB API instance
pub fn new_ib_api(host : String, port : Int, client_id : Int) -> IBApi {
  let config = ConnectionConfig::{
    host,
    port,
    client_id,
    connect_options: Some(default_connect_options()),
  }
  let cl = new_client(config)
  { client: cl }
}

///|
// Connect to IB TWS or Gateway
pub fn api_connect(api : IBApi) -> Result[IBApi, ApiError] {
  match client_connect(api.client) {
    Ok(new_client) => Ok({ client: new_client })
    Err(e) => {
      let error_msg = match e {
        ConnectionFailed(msg) => "Connection failed: " + msg
        AlreadyConnected => "Already connected"
        _ => "Unknown connection error"
      }
      Err(ClientError(error_msg))
    }
  }
}

///|
// Disconnect from IB TWS or Gateway
pub fn api_disconnect(api : IBApi) -> Result[IBApi, ApiError] {
  match client_disconnect(api.client) {
    Ok(new_client) => Ok({ client: new_client })
    Err(e) => {
      let error_msg = match e {
        NotConnected => "Not connected"
        _ => "Unknown disconnection error"
      }
      Err(ClientError(error_msg))
    }
  }
}

///|
// Check if connected
pub fn api_is_connected(api : IBApi) -> Bool {
  client_is_connected(api.client)
}

///|
// Subscribe to market data for a contract
pub fn subscribe_market_data(
  api : IBApi,
  contract : Contract,
) -> Result[Int, ApiError] {
  if !api_is_connected(api) {
    return Err(InvalidState("Not connected"))
  }
  let req_id = api.client.next_order_id
  match req_market_data(api.client, req_id, contract) {
    Ok(_) => Ok(req_id)
    Err(e) => Err(ClientError("Failed to subscribe to market data"))
  }
}

///|
// Unsubscribe from market data
pub fn unsubscribe_market_data(
  api : IBApi,
  req_id : Int,
) -> Result[Unit, ApiError] {
  if !api_is_connected(api) {
    return Err(InvalidState("Not connected"))
  }
  match cancel_market_data(api.client, req_id) {
    Ok(_) => Ok(())
    Err(e) => Err(ClientError("Failed to unsubscribe from market data"))
  }
}

///|
// Place a market order
pub fn place_market_order(
  api : IBApi,
  contract : Contract,
  action : OrderAction,
  quantity : Double,
) -> Result[Int, ApiError] {
  if !api_is_connected(api) {
    return Err(InvalidState("Not connected"))
  }
  let order = default_order()
  let order = Order::{
    order_id: api.client.next_order_id,
    client_id: order.client_id,
    action,
    total_quantity: quantity,
    order_type: Market,
    lmt_price: order.lmt_price,
    aux_price: order.aux_price,
    time_in_force: order.time_in_force,
    oca_group: order.oca_group,
    oca_type: order.oca_type,
    account: order.account,
    open_close: order.open_close,
    origin: order.origin,
    transmit: order.transmit,
    parent_id: order.parent_id,
    block_order: order.block_order,
    sweep_to_fill: order.sweep_to_fill,
    display_size: order.display_size,
    trigger_method: order.trigger_method,
    outside_rth: order.outside_rth,
    hidden: order.hidden,
    discretionary_amt: order.discretionary_amt,
    good_after_time: order.good_after_time,
    good_till_date: order.good_till_date,
    fa_group: order.fa_group,
    fa_method: order.fa_method,
    fa_percentage: order.fa_percentage,
    all_or_none: order.all_or_none,
    min_qty: order.min_qty,
    percent_offset: order.percent_offset,
    eTrade_only: order.eTrade_only,
    firm_quote_only: order.firm_quote_only,
    nbbo_price_cap: order.nbbo_price_cap,
    opt_out_smart_routing: order.opt_out_smart_routing,
    scale_init_level_size: order.scale_init_level_size,
    scale_subs_level_size: order.scale_subs_level_size,
    scale_price_increment: order.scale_price_increment,
    scale_price_adjust_value: order.scale_price_adjust_value,
    scale_price_adjust_interval: order.scale_price_adjust_interval,
    scale_profit_offset: order.scale_profit_offset,
    scale_auto_reset: order.scale_auto_reset,
    scale_init_position: order.scale_init_position,
    scale_init_fill_qty: order.scale_init_fill_qty,
    scale_random_percent: order.scale_random_percent,
    hedge_type: order.hedge_type,
    hedge_param: order.hedge_param,
    algo_strategy: order.algo_strategy,
    algo_params: order.algo_params,
    smart_combo_routing_params: order.smart_combo_routing_params,
    what_if: order.what_if,
    not_held: order.not_held,
  }
  match place_order(api.client, order.order_id, contract, order) {
    Ok(_) => Ok(order.order_id)
    Err(e) => Err(ClientError("Failed to place market order"))
  }
}

///|
// Place a limit order
pub fn place_limit_order(
  api : IBApi,
  contract : Contract,
  action : OrderAction,
  quantity : Double,
  limit_price : Double,
) -> Result[Int, ApiError] {
  if !api_is_connected(api) {
    return Err(InvalidState("Not connected"))
  }
  let order = default_order()
  let order = Order::{
    order_id: api.client.next_order_id,
    client_id: order.client_id,
    action,
    total_quantity: quantity,
    order_type: Limit,
    lmt_price: limit_price,
    aux_price: order.aux_price,
    time_in_force: order.time_in_force,
    oca_group: order.oca_group,
    oca_type: order.oca_type,
    account: order.account,
    open_close: order.open_close,
    origin: order.origin,
    transmit: order.transmit,
    parent_id: order.parent_id,
    block_order: order.block_order,
    sweep_to_fill: order.sweep_to_fill,
    display_size: order.display_size,
    trigger_method: order.trigger_method,
    outside_rth: order.outside_rth,
    hidden: order.hidden,
    discretionary_amt: order.discretionary_amt,
    good_after_time: order.good_after_time,
    good_till_date: order.good_till_date,
    fa_group: order.fa_group,
    fa_method: order.fa_method,
    fa_percentage: order.fa_percentage,
    all_or_none: order.all_or_none,
    min_qty: order.min_qty,
    percent_offset: order.percent_offset,
    eTrade_only: order.eTrade_only,
    firm_quote_only: order.firm_quote_only,
    nbbo_price_cap: order.nbbo_price_cap,
    opt_out_smart_routing: order.opt_out_smart_routing,
    scale_init_level_size: order.scale_init_level_size,
    scale_subs_level_size: order.scale_subs_level_size,
    scale_price_increment: order.scale_price_increment,
    scale_price_adjust_value: order.scale_price_adjust_value,
    scale_price_adjust_interval: order.scale_price_adjust_interval,
    scale_profit_offset: order.scale_profit_offset,
    scale_auto_reset: order.scale_auto_reset,
    scale_init_position: order.scale_init_position,
    scale_init_fill_qty: order.scale_init_fill_qty,
    scale_random_percent: order.scale_random_percent,
    hedge_type: order.hedge_type,
    hedge_param: order.hedge_param,
    algo_strategy: order.algo_strategy,
    algo_params: order.algo_params,
    smart_combo_routing_params: order.smart_combo_routing_params,
    what_if: order.what_if,
    not_held: order.not_held,
  }
  match place_order(api.client, order.order_id, contract, order) {
    Ok(_) => Ok(order.order_id)
    Err(e) => Err(ClientError("Failed to place limit order"))
  }
}

///|
// Place a stop order
pub fn place_stop_order(
  api : IBApi,
  contract : Contract,
  action : OrderAction,
  quantity : Double,
  stop_price : Double,
) -> Result[Int, ApiError] {
  if !api_is_connected(api) {
    return Err(InvalidState("Not connected"))
  }
  let order = default_order()
  let order = Order::{
    order_id: api.client.next_order_id,
    client_id: order.client_id,
    action,
    total_quantity: quantity,
    order_type: Stop,
    lmt_price: order.lmt_price,
    aux_price: stop_price,
    time_in_force: order.time_in_force,
    oca_group: order.oca_group,
    oca_type: order.oca_type,
    account: order.account,
    open_close: order.open_close,
    origin: order.origin,
    transmit: order.transmit,
    parent_id: order.parent_id,
    block_order: order.block_order,
    sweep_to_fill: order.sweep_to_fill,
    display_size: order.display_size,
    trigger_method: order.trigger_method,
    outside_rth: order.outside_rth,
    hidden: order.hidden,
    discretionary_amt: order.discretionary_amt,
    good_after_time: order.good_after_time,
    good_till_date: order.good_till_date,
    fa_group: order.fa_group,
    fa_method: order.fa_method,
    fa_percentage: order.fa_percentage,
    all_or_none: order.all_or_none,
    min_qty: order.min_qty,
    percent_offset: order.percent_offset,
    eTrade_only: order.eTrade_only,
    firm_quote_only: order.firm_quote_only,
    nbbo_price_cap: order.nbbo_price_cap,
    opt_out_smart_routing: order.opt_out_smart_routing,
    scale_init_level_size: order.scale_init_level_size,
    scale_subs_level_size: order.scale_subs_level_size,
    scale_price_increment: order.scale_price_increment,
    scale_price_adjust_value: order.scale_price_adjust_value,
    scale_price_adjust_interval: order.scale_price_adjust_interval,
    scale_profit_offset: order.scale_profit_offset,
    scale_auto_reset: order.scale_auto_reset,
    scale_init_position: order.scale_init_position,
    scale_init_fill_qty: order.scale_init_fill_qty,
    scale_random_percent: order.scale_random_percent,
    hedge_type: order.hedge_type,
    hedge_param: order.hedge_param,
    algo_strategy: order.algo_strategy,
    algo_params: order.algo_params,
    smart_combo_routing_params: order.smart_combo_routing_params,
    what_if: order.what_if,
    not_held: order.not_held,
  }
  match place_order(api.client, order.order_id, contract, order) {
    Ok(_) => Ok(order.order_id)
    Err(e) => Err(ClientError("Failed to place stop order"))
  }
}

///|
// Cancel an order
pub fn api_cancel_order(api : IBApi, order_id : Int) -> Result[Unit, ApiError] {
  if !api_is_connected(api) {
    return Err(InvalidState("Not connected"))
  }
  match client_cancel_order(api.client, order_id) {
    Ok(_) => Ok(())
    Err(e) => Err(ClientError("Failed to cancel order"))
  }
}

///|
// Get all open orders
pub fn get_open_orders(api : IBApi) -> Result[Unit, ApiError] {
  if !api_is_connected(api) {
    return Err(InvalidState("Not connected"))
  }
  match req_open_orders(api.client) {
    Ok(_) => Ok(())
    Err(e) => Err(ClientError("Failed to request open orders"))
  }
}

///|
// Get current positions
pub fn get_positions(api : IBApi) -> Result[Unit, ApiError] {
  if !api_is_connected(api) {
    return Err(InvalidState("Not connected"))
  }
  match req_positions(api.client) {
    Ok(_) => Ok(())
    Err(e) => Err(ClientError("Failed to request positions"))
  }
}

///|
// Get account summary
pub fn get_account_summary(api : IBApi, tags : String) -> Result[Int, ApiError] {
  if !api_is_connected(api) {
    return Err(InvalidState("Not connected"))
  }
  let req_id = api.client.next_order_id
  match req_account_summary(api.client, req_id, "All", tags) {
    Ok(_) => Ok(req_id)
    Err(e) => Err(ClientError("Failed to request account summary"))
  }
}

///|
// Get managed accounts
pub fn get_managed_accounts(api : IBApi) -> Result[Unit, ApiError] {
  if !api_is_connected(api) {
    return Err(InvalidState("Not connected"))
  }
  match req_managed_accounts(api.client) {
    Ok(_) => Ok(())
    Err(e) => Err(ClientError("Failed to request managed accounts"))
  }
}

///|
// Get account value
pub fn get_account_value(api : IBApi) -> Result[Unit, ApiError] {
  if !api_is_connected(api) {
    return Err(InvalidState("Not connected"))
  }
  match req_account_updates(api.client, true, "") {
    Ok(_) => Ok(())
    Err(e) => Err(ClientError("Failed to request account updates"))
  }
}

///|
// Get historical data
pub fn get_historical_data(
  api : IBApi,
  contract : Contract,
  end_date_time : String,
  duration_str : String,
  bar_size : BarSize,
  what_to_show : WhatToShow,
) -> Result[Int, ApiError] {
  if !api_is_connected(api) {
    return Err(InvalidState("Not connected"))
  }
  let req_id = api.client.next_order_id
  match
    req_historical_data(
      api.client,
      req_id,
      contract,
      end_date_time,
      duration_str,
      bar_size,
      what_to_show,
      true,
      1,
      false,
    ) {
    Ok(_) => Ok(req_id)
    Err(e) => Err(ClientError("Failed to request historical data"))
  }
}

///|
// Get contract details
pub fn get_contract_details(
  api : IBApi,
  contract : Contract,
) -> Result[Int, ApiError] {
  if !api_is_connected(api) {
    return Err(InvalidState("Not connected"))
  }
  let req_id = api.client.next_order_id
  match req_contract_details(api.client, req_id, contract) {
    Ok(_) => Ok(req_id)
    Err(e) => Err(ClientError("Failed to request contract details"))
  }
}

///|
// Get execution details
pub fn get_executions(api : IBApi) -> Result[Unit, ApiError] {
  if !api_is_connected(api) {
    return Err(InvalidState("Not connected"))
  }
  let filter = default_execution_filter()
  match req_executions(api.client, api.client.next_order_id, filter) {
    Ok(_) => Ok(())
    Err(e) => Err(ClientError("Failed to request executions"))
  }
}

///|
// Request next valid order ID
pub fn request_next_order_id(api : IBApi) -> Result[Int, ApiError] {
  if !api_is_connected(api) {
    return Err(InvalidState("Not connected"))
  }
  match req_ids(api.client, 1) {
    Ok(_) => Ok(api.client.next_order_id)
    Err(e) => Err(ClientError("Failed to request order ID"))
  }
}

///|
// Helper: Create a stock contract
pub fn stock_contract(
  symbol : String,
  exchange : String,
  currency : String,
) -> Contract {
  let contract = default_contract()
  Contract::{
    con_id: contract.con_id,
    symbol,
    sec_type: Stock,
    last_trade_date_or_contract_month: contract.last_trade_date_or_contract_month,
    strike: contract.strike,
    right: contract.right,
    multiplier: contract.multiplier,
    exchange,
    primary_exchange: contract.primary_exchange,
    currency,
    local_symbol: contract.local_symbol,
    trading_class: contract.trading_class,
    include_expired: contract.include_expired,
    sec_id_type: contract.sec_id_type,
    sec_id: contract.sec_id,
  }
}

///|
// Helper: Create a forex contract
pub fn forex_contract(
  symbol : String,
  exchange : String,
  currency : String,
) -> Contract {
  let contract = default_contract()
  Contract::{
    con_id: contract.con_id,
    symbol,
    sec_type: Forex,
    last_trade_date_or_contract_month: contract.last_trade_date_or_contract_month,
    strike: contract.strike,
    right: contract.right,
    multiplier: contract.multiplier,
    exchange,
    primary_exchange: contract.primary_exchange,
    currency,
    local_symbol: contract.local_symbol,
    trading_class: contract.trading_class,
    include_expired: contract.include_expired,
    sec_id_type: contract.sec_id_type,
    sec_id: contract.sec_id,
  }
}

///|
// Helper: Create an option contract
pub fn option_contract(
  symbol : String,
  last_trade_date : String,
  strike : Double,
  right : String,
  exchange : String,
  currency : String,
) -> Contract {
  let contract = default_contract()
  Contract::{
    con_id: contract.con_id,
    symbol,
    sec_type: Option,
    last_trade_date_or_contract_month: last_trade_date,
    strike,
    right,
    multiplier: contract.multiplier,
    exchange,
    primary_exchange: contract.primary_exchange,
    currency,
    local_symbol: contract.local_symbol,
    trading_class: contract.trading_class,
    include_expired: contract.include_expired,
    sec_id_type: contract.sec_id_type,
    sec_id: contract.sec_id,
  }
}

///|
// Helper: Create a futures contract
pub fn futures_contract(
  symbol : String,
  last_trade_date : String,
  exchange : String,
  currency : String,
) -> Contract {
  let contract = default_contract()
  Contract::{
    con_id: contract.con_id,
    symbol,
    sec_type: Future,
    last_trade_date_or_contract_month: last_trade_date,
    strike: contract.strike,
    right: contract.right,
    multiplier: contract.multiplier,
    exchange,
    primary_exchange: contract.primary_exchange,
    currency,
    local_symbol: contract.local_symbol,
    trading_class: contract.trading_class,
    include_expired: contract.include_expired,
    sec_id_type: contract.sec_id_type,
    sec_id: contract.sec_id,
  }
}

///|
// Set error callback
pub fn on_error(api : IBApi, callback : (ErrorCode, String) -> Unit) -> IBApi {
  let new_client = set_error_callback(api.client, callback)
  { client: new_client }
}

///|
// Set tick price callback
pub fn on_tick_price(
  api : IBApi,
  callback : (Int, TickType, Double, Int64) -> Unit,
) -> IBApi {
  let new_client = set_tick_price_callback(api.client, callback)
  { client: new_client }
}

///|
// Set tick size callback
pub fn on_tick_size(
  api : IBApi,
  callback : (Int, TickType, Int) -> Unit,
) -> IBApi {
  let new_client = set_tick_size_callback(api.client, callback)
  { client: new_client }
}

///|
// Set order status callback
pub fn on_order_status(
  api : IBApi,
  callback : (
    Int,
    String,
    Double,
    Double,
    Double,
    Int,
    Int,
    Double,
    Int,
    String,
  ) -> Unit,
) -> IBApi {
  let new_client = set_order_status_callback(api.client, callback)
  { client: new_client }
}

///|
// Set open order callback
pub fn on_open_order(
  api : IBApi,
  callback : (Int, Contract, Order, OrderState) -> Unit,
) -> IBApi {
  let new_client = set_open_order_callback(api.client, callback)
  { client: new_client }
}

///|
// Set execution callback
pub fn on_execution(
  api : IBApi,
  callback : (Int, Contract, Execution) -> Unit,
) -> IBApi {
  let new_client = set_execution_callback(api.client, callback)
  { client: new_client }
}

///|
// Set account summary callback
pub fn on_account_summary(
  api : IBApi,
  callback : (Int, String, String, String, String) -> Unit,
) -> IBApi {
  let new_client = set_account_summary_callback(api.client, callback)
  { client: new_client }
}

///|
// Set position callback
pub fn on_position(
  api : IBApi,
  callback : (String, Contract, Double, Double) -> Unit,
) -> IBApi {
  let new_client = set_position_callback(api.client, callback)
  { client: new_client }
}

///|
// Set historical data callback
pub fn on_historical_data(
  api : IBApi,
  callback : (Int, String, HistoricalDataBar) -> Unit,
) -> IBApi {
  let new_client = set_historical_data_callback(api.client, callback)
  { client: new_client }
}

///|
// Set managed accounts callback
pub fn on_managed_accounts(api : IBApi, callback : (String) -> Unit) -> IBApi {
  let new_client = set_managed_accounts_callback(api.client, callback)
  { client: new_client }
}

///|
// Process messages (should be called in a loop)
pub fn api_process_messages(api : IBApi) -> Result[IBApi, ApiError] {
  match client_process_messages(api.client) {
    Ok(new_client) => Ok({ client: new_client })
    Err(e) => {
      let error_msg = match e {
        NotConnected => "Not connected"
        SendError(msg) => "Send error: " + msg
        ReceiveError(msg) => "Receive error: " + msg
        _ => "Unknown error"
      }
      Err(ClientError(error_msg))
    }
  }
}
