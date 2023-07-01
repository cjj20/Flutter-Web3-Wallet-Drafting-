import 'package:flutter/cupertino.dart';
import 'package:flutter_web3/ethereum.dart';
class MetaMaskProvider extends ChangeNotifier {
  static const operatingChain = 4;
  String currentAddress = '';
  var account = "";
  int currentChain = -1;
  bool get isEnabled => ethereum != null;
  bool get isInOperatingChain => currentChain == operatingChain;
  bool get isConnected => isEnabled && currentAddress.isNotEmpty;
  Future<void> connect() async {
   if (isEnabled) {
    final accs = await ethereum!.requestAccount();
    if (accs.isNotEmpty) {
      currentAddress = accs.first;
      currentChain = await ethereum!.getChainId();
      notifyListeners();
    }
    update();
    }
   }

  clear() {
   currentAddress = '';
   currentChain = -1;
   notifyListeners();
  }

  init() {
   if (isEnabled) {
    ethereum!.onAccountsChanged((accs) {
     clear();
   });
   ethereum!.onChainChanged((chain) {
    clear();
   });
  }
 }
}


