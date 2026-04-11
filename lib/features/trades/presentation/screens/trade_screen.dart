import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';
import '../../data/models/coin.dart';
import '../../data/models/trade_enums.dart';
import '../widgets/trade/coin_header.dart';
import '../widgets/trade/price_chart.dart';
import '../widgets/trade/buy_sell_toggle.dart';
import '../widgets/trade/order_type_selector.dart';
import '../widgets/trade/amount_input_section.dart';
import '../widgets/trade/balance_section.dart';
import '../widgets/trade/trade_summary.dart';
import '../widgets/trade/trade_button.dart';
import '../widgets/trade/recent_trades_list.dart';

class TradeScreen extends StatefulWidget {
  const TradeScreen({super.key});

  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {
  TradeType _tradeType = TradeType.buy;
  OrderType _orderType = OrderType.market;
  String _amount = '0.00';

  final mockCoin = Coin(
    id: 'bitcoin',
    name: 'Bitcoin',
    symbol: 'btc',
    price: 42345.21,
    priceChange24h: 2.45,
    marketRank: 1,
    imageUrl: 'https://assets.coingecko.com/coins/images/1/large/bitcoin.png',
  );

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CoinHeader(coin: mockCoin),
            const SizedBox(height: 24),
            const PriceChart(),
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
              symbol: mockCoin.symbol,
              onAmountChanged: (String val) => setState(() => _amount = val),
            ),
            const SizedBox(height: 16),
            const BalanceSection(balance: 12500.50, currency: 'USDT'),
            const SizedBox(height: 16),
            TradeSummary(
              payAmount: double.tryParse(_amount) ?? 0,
              receiveAmount: (double.tryParse(_amount) ?? 0) / mockCoin.price,
              fees: 2.50,
              payCurrency: 'USDT',
              receiveCurrency: mockCoin.symbol.toUpperCase(),
            ),
            const SizedBox(height: 24),
            TradeButton(
              tradeType: _tradeType,
              coinSymbol: mockCoin.symbol,
              onPressed: () {
                // Execute Trade Logic
              },
            ),
            const SizedBox(height: 32),
            const RecentTradesList(),
            const SizedBox(height: 100), // Space for bottom navigation
          ],
        ),
      ),
    );
  }
}
