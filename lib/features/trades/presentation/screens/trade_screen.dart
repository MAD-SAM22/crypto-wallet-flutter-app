import 'package:crypto_project/core/di/dependency_injection.dart';
import 'package:crypto_project/features/trades/presentation/logic/trade_cubit.dart';
import 'package:crypto_project/features/trades/presentation/logic/trade_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../theme/app_colors.dart';
import '../../data/models/coin.dart';
import '../../data/models/trade_enums.dart';
import '../widgets/balance_section.dart';
import '../widgets/buy_sell_toggle.dart';
import '../widgets/coin_header.dart';
import '../widgets/order_type_selector.dart';
import '../widgets/price_chart.dart';
import '../widgets/recent_trades_list.dart';

import '../widgets/amount_input_section.dart';

import '../widgets/trade_button.dart';
import '../widgets/trade_summary.dart';

class TradeScreen extends StatelessWidget {
  const TradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TradeCubit>()..getCoins(),
      child: const TradeScreenBody(),
    );
  }
}

class TradeScreenBody extends StatefulWidget {
  const TradeScreenBody({super.key});

  @override
  State<TradeScreenBody> createState() => _TradeScreenBodyState();
}

class _TradeScreenBodyState extends State<TradeScreenBody> {
  TradeType _tradeType = TradeType.buy;
  OrderType _orderType = OrderType.market;
  String _amount = '0.00';
  Coin? _selectedCoin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Trade',
          style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<TradeCubit, TradeState>(
        builder: (context, state) {
          if (state is TradeInitial || state is TradeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TradeError) {
            return Center(child: Text(state.error));
          } else if (state is TradeSuccess) {
            final coins = state.coins;
            _selectedCoin ??= coins.first;
            
            return RefreshIndicator(
              onRefresh: () async {
                context.read<TradeCubit>().getCoins();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_selectedCoin != null) ...[
                      GestureDetector(
                        onTap: () => _showCoinPicker(context, coins),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundGrey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Expanded(child: CoinHeader(coin: _selectedCoin!)),
                              const Icon(Icons.keyboard_arrow_down_rounded),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      PriceChart(
                        chartData: state.chartData,
                        isLoading: state.isChartLoading,
                        onFilterChanged: (days) {
                          context.read<TradeCubit>().getChartData(_selectedCoin!.id, days);
                        },
                      ),
                      const SizedBox(height: 24),
                      BuySellToggle(
                        selectedType: _tradeType,
                        onChanged: (TradeType type) => setState(() => _tradeType = type),
                      ),
                      const SizedBox(height: 16),
                      OrderTypeSelector(
                        selectedOrderType: _orderType,
                        onChanged: (OrderType type) => setState(() => _orderType = type),
                      ),
                      const SizedBox(height: 16),
                      AmountInputSection(
                        symbol: _selectedCoin!.symbol,
                        onAmountChanged: (String val) => setState(() => _amount = val),
                      ),
                      const SizedBox(height: 16),
                      const BalanceSection(balance: 12500.50, currency: 'USDT'),
                      const SizedBox(height: 16),
                      TradeSummary(
                        payAmount: double.tryParse(_amount) ?? 0,
                        receiveAmount: _calculateReceiveAmount(),
                        fees: 2.50,
                        payCurrency: _tradeType == TradeType.buy ? 'USDT' : _selectedCoin!.symbol.toUpperCase(),
                        receiveCurrency: _tradeType == TradeType.buy ? _selectedCoin!.symbol.toUpperCase() : 'USDT',
                      ),
                      const SizedBox(height: 24),
                      TradeButton(
                        tradeType: _tradeType,
                        coinSymbol: _selectedCoin!.symbol,
                        onPressed: () {
                          // Execute Trade Logic
                        },
                      ),
                      const SizedBox(height: 32),
                      const RecentTradesList(),
                    ],
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  double _calculateReceiveAmount() {
    if (_selectedCoin == null) return 0;
    double amount = double.tryParse(_amount) ?? 0;
    if (_tradeType == TradeType.buy) {
      return amount / _selectedCoin!.currentPrice;
    } else {
      return amount * _selectedCoin!.currentPrice;
    }
  }

  void _showCoinPicker(BuildContext context, List<Coin> coins) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text("Select Asset", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: coins.length,
                  itemBuilder: (context, index) {
                    final coin = coins[index];
                    return ListTile(
                      leading: CircleAvatar(backgroundImage: NetworkImage(coin.image)),
                      title: Text(coin.name),
                      subtitle: Text(coin.symbol.toUpperCase()),
                      trailing: Text("\$${coin.currentPrice.toStringAsFixed(2)}"),
                      onTap: () {
                        setState(() {
                          _selectedCoin = coin;
                        });
                        // Fetch chart for the newly selected coin
                        context.read<TradeCubit>().getChartData(coin.id, '1');
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
