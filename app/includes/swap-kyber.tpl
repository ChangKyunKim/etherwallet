<!-- Swap Start Kyber 2 -->
<article ng-if="isKyberSwap">

    <!-- Swap Kyber 2 -->
    <article class="swap-start" ng-show="showStage2Kyber">


        <!-- Title -->
        <section class="row">
            <h5 class="col-xs-6 col-xs-offset-3" translate="SWAP_information">Your Information</h5>

        </section>
        <!-- Title -->


        <!-- Info Row -->
        <section class="order-info-wrap row">
            <div class="col-sm-4 order-info">
                <h4> {{swapOrder.fromVal  | number: 6}} {{swapOrder.fromCoin}} </h4>
                <p translate="SWAP_send_amt"> Amount to send </p>
            </div>
            <div class="col-sm-4 order-info">
                <h4> {{swapOrder.toVal  | number: 6}} {{swapOrder.toCoin}} </h4>
                <p translate="SWAP_rec_amt"> Amount to receive </p>
            </div>
            <div class="col-sm-4 order-info">
                <h4> {{swapOrder.swapRate  | number: 6}} {{swapOrder.swapPair}} </h4>
                <p translate="SWAP_your_rate"> Your rate </p>
            </div>
        </section>
        <!-- / Info Row -->

        <!-- Your Address -->
        <section class="swap-address block">
            <section class="row">
                <div class="col-sm-2 text-center">
                    <em>
                        <small>Powered By</small>
                    </em>
                    <a class="link" href="https://home.kyber.network/" target="_blank"
                       rel="noopener noreferrer">
                        <img class="pull-right" src="images/logo-kyber.svg" width="200" height="111"/>
                    </a>
                </div>


                <div class="col-sm-8 col-xs-12">
                    <label><span translate="SWAP_rec_add">Your Receiving Address </span> <strong>({{swapOrder.toCoin}})</strong></label>
                    <!-- todo should I just wait for the wallet unlock and not ask for an address first.  then if wallet uplock calculation proves false at send tx.  present option to return to start???-->
                    <address-field placeholder="0xDECAF9CD2367cdbb726E904cD6397eDFcAe6068D"
                                   var-name="swapOrder.toAddress"></address-field>
                </div>
            </section>
            <!-- /Your Address -->
            <!-- CTA -->

            <section class="row text-center" ng-if="!kyberReturnToStart">

                <a ng-click="startKyber()" class="btn btn-primary btn-lg"><span
                        translate="SWAP_start_CTA"> Start Swap </span></a>
            </section>

            <!-- / CTA -->
        </section>



    </article>
    <!-- / Swap Kyber 2 -->

    <!----------------------------------------------------------------------------------------------------------------->
    <!-- Swap Kyber 3-->
    <article class="swap-order" ng-show="showStage3Kyber">

        <!-- Title -->
        <section class="row text-center">
            <div class="col-xs-3 text-left"><a class="btn btn-danger btn-xs" ng-click="newSwap()"> Start New Swap </a>
                <!-- todo: fix issues where new BigNumber() is not a number in sendTxCtrl: $scope.hasEnoughBalance function-->
            </div>
            <h5 class="col-xs-6" translate="SWAP_information">Your Information</h5>
        </section>

        <!-- Order Info -->
        <section class="row order-info-wrap">
            <div class="col-sm-6 order-info">
                <h4>{{kyberOrderResult.output.amount  | number: 6}} {{kyberOrderResult.output.currency}}</h4>
                <p translate="SWAP_rec_amt">Amount to receive</p>
            </div>
            <div class="col-sm-6 order-info">
                <h4>{{swapOrder.swapRate  | number: 6}} {{swapOrder.swapPair}}</h4>
                <p translate="SWAP_your_rate">Your rate</p>
            </div>
        </section>

        <!-- Swap Progress -->
        <section class="row swap-progress">
            <div class="sep"></div>
            <div class="progress-item {{kyberOrderResult.progress.bar[0]}}">
                <div class="progress-circle"><i>1</i></div>
                <p translate="SWAP_progress_1">Order Initiated</p>
            </div>
            <div class="progress-item {{kyberOrderResult.progress.bar[1]}}" ng-if="!kyberEthToToken">
                <div class="progress-circle"><i>2</i></div>
                <p><span translate="SWAP_progress_2">Waiting for your </span>
                    {{kyberOrderResult.input.currency}}...</p>
            </div>
            <div class="progress-item {{kyberOrderResult.progress.bar[2]}}" ng-if="!kyberEthToToken">
                <div class="progress-circle"><i>3</i></div>
                <p>{{kyberOrderResult.input.currency}} <span translate="SWAP_progress_3">Received!</span></p>
            </div>
            <div class="progress-item {{kyberOrderResult.progress.bar[3]}}">
                <div class="progress-circle"><i>4</i></div>
                <p>
                    <span translate="SWAP_progress_4">Sending your </span> {{kyberOrderResult.output.currency}}
                    <br/>
                </p>
            </div>
            <div class="progress-item {{kyberOrderResult.progress.bar[4]}}">
                <div class="progress-circle"><i>5</i></div>
                <p translate="SWAP_progress_5">Order Complete</p>
            </div>
        </section>


        <div class="row">
            <div class="col-sm-1 text-center">
                <div class="row">
                    <em>
                        <small>Powered By</small>
                    </em>
                    <a class="link clearfix" href="https://home.kyber.network/" target="_blank"
                       rel="noopener noreferrer">
                        <img class="pull-right" src="images/logo-kyber.svg" width="200" height="111"/>
                    </a>
                </div>

            </div>
            <div class="col-sm-11">
                <!-- Swap CTA -->
                <section class="row text-center" ng-show="kyberOrderResult.progress.status=='OPEN_ETH'">
                    <h1>
                <span
                        translate="SWAP_order_CTA">      Please send                                                 </span>
                        <strong> {{kyberOrderResult.input.amount}} {{kyberOrderResult.input.currency}} </strong>
                    </h1>

                </section>

                <section class="row text-center"
                         ng-show="kyberOrderResult.progress.status=='GENERATE_SWAP_TRANSACTION'">
                    <h1>
                        <span>      You are about to Swap                                           </span>
                        <!-- todo: add translate -->
                        <strong> {{kyberOrderResult.input.amount}} {{kyberOrderResult.input.currency}} </strong>
                    </h1>
                </section>
            </div>
        </div>
        <!-- Swap CTA ETH -->
        <article class="row">

            <section class="clearfix collapse-container">
                <div class="text-center" ng-click="wd = !wd">
                    <a class="collapse-button"><span ng-show="wd">+</span><span ng-show="!wd">-</span></a>
                    <h5>Unlock your wallet to proceed.</h5>  <!-- todo: add translate -->
                </div>
                <div ng-show="!wd">
                    @@if (site === 'mew' ) {
                    <wallet-decrypt-drtv></wallet-decrypt-drtv>
                    }
                    @@if (site === 'cx' ) {
                    <cx-wallet-decrypt-drtv></cx-wallet-decrypt-drtv>
                    }
                </div>
            </section>
            <div class="alert alert-danger" ng-show="ajaxReq.type!=='ETH' && ajaxReq.type!=='ROPSTEN ETH'">
                <strong>Warning! You are not connected to an ETH node.</strong> <br/>
                Please use the node switcher in the top-right corner to switch to an ETH node. We <strong>do
                                                                                                          not</strong>
                support swapping ETC or Testnet ETH.
            </div>

            <section class="row" ng-show="wallet!=null " ng-controller="sendTxCtrl">
                <h5 class="row text-center">Wallet Unlocked!</h5>  <!-- todo: add translate -->

                <section class="row text-center" ng-if="kyberReturnToStart">
                    <h5 class="text-warning">The swap value of  {{swapOrder.fromVal}} {{swapOrder.fromCoin}} is Greater than your current {{swapOrder.fromCoin}} Balance of {{userTokenBalanceChecked}} {{swapOrder.fromCoin}}</h5>
                    <a ng-click="returnToStart()" class="btn btn-primary btn-lg"><span> Return to Swap Selector </span></a>
                    <!-- todo: add translate -->
                </section>
                <section class="row text-center" ng-show="wallet!=null && !kyberReturnToStart && balanceOk">
                    <a ng-click="openKyberOrder(wallet)" class="btn btn-primary btn-lg"><span
                            translate="SWAP_start_CTA"> Start Swap </span></a>
                </section>


                <!-- Included Because sendTxCtrl.js looks for it via querySelector and throws if it is not present (and destroys the layout in the process)-->
                <div id="sendTransaction"></div>

                @@if (site === 'mew' ) { @@include( './swap-kyber-modal.tpl', { "site": "mew" } ) }
                <!--todo implement (custom swap modal) with content comming from swapCtrl -->
                @@if (site === 'cx' ) { @@include( './swap-kyber-modal.tpl', { "site": "cx" } ) }

            </section>
            <!--</div>-->
        </article>
        <!-- / Swap CTA ETH -->


    </article>

    <!-- / Swap Kyber 3-->

    <!----------------------------------------------------------------------------------------------------------------->
    <!-- Swap Kyber 4-->
    <article class="swap-order" ng-show="showStage4Kyber">

        <!-- Title -->
        <section class="row text-center">
            <div class="col-xs-3 text-left"><a class="btn btn-danger btn-xs" ng-click="newSwap()"> Start New Swap </a>
                <!-- todo: fix issues where new BigNumber() is not a number in sendTxCtrl: $scope.hasEnoughBalance function-->
            </div>
            <h5 class="col-xs-6" translate="SWAP_information">Your Information</h5>

        </section>

        <!-- Order Info -->
        <section class="row order-info-wrap">
            <div class="col-sm-6 order-info">
                <h4>{{kyberOrderResult.output.amount  | number: 6}} {{kyberOrderResult.output.currency}}</h4>
                <p translate="SWAP_rec_amt">Amount to receive</p>
            </div>
            <div class="col-sm-6 order-info">
                <h4>{{swapOrder.swapRate | number: 6}} {{swapOrder.swapPair}}</h4>
                <p translate="SWAP_your_rate">Your rate</p>
            </div>
        </section>


        <!-- Swap Progress -->
        <section class="row swap-progress">
            <div class="sep"></div>
            <div class="progress-item {{kyberOrderResult.progress.bar[0]}}">
                <div class="progress-circle"><i>1</i></div>
                <p translate="SWAP_progress_1">Order Initiated</p>
            </div>
            <div class="progress-item {{kyberOrderResult.progress.bar[1]}}" ng-if="!kyberEthToToken">
                <div class="progress-circle"><i>2</i></div>
                <p><span translate="SWAP_progress_2">Waiting for your </span> {{kyberOrderResult.input.currency}}...</p>
            </div>
            <div class="progress-item {{kyberOrderResult.progress.bar[2]}}" ng-if="!kyberEthToToken">
                <div class="progress-circle"><i>3</i></div>
                <p>{{kyberOrderResult.input.currency}} <span translate="SWAP_progress_3">Received!</span></p>
            </div>
            <div class="progress-item {{kyberOrderResult.progress.bar[3]}}" >
                <div class="progress-circle"><i>4</i></div>
                <p>
                    <span translate="SWAP_progress_4">Sending your </span> {{kyberOrderResult.output.currency}} <br/>
                </p>
            </div>
            <div class="progress-item {{kyberOrderResult.progress.bar[4]}}">
                <div class="progress-circle"><i>5</i></div>
                <p translate="SWAP_progress_5">Order Complete</p>
            </div>
        </section>

        <article class="row">
            <div class="col-sm-2 text-center">
                <em>
                    <small>Powered By</small>
                </em>
                <a class="link" href="https://home.kyber.network/" target="_blank"
                   rel="noopener noreferrer">
                    <img class="pull-right" src="images/logo-kyber.svg" width="400" height="222"/>
                </a>
            </div>
            <div class="col-sm-10 text-justify">
                <div class="row">
                    <section class="col-sm-6">
                        <div class="col-sm-12">
                            <h3>Transaction Summary:</h3>
                        </div>
                        <div class="col-sm-12">
                            <h4>{{kyberOrderResult.input.amount}} {{kyberOrderResult.input.currency}}</h4>
                            <p >Amount sent</p>
                        </div>
                        <div class="col-sm-12">
                            <h4>{{kyberOrderResult.output.amount}} {{kyberOrderResult.output.currency}}</h4>
                            <p translate="SWAP_rec_amt">Amount to receive</p>
                        </div>
                        <div class="col-sm-12">
                            <h4>{{swapOrder.swapRate  | number: 6}} {{swapOrder.swapPair}}</h4>
                            <p translate="SWAP_your_rate">Your rate</p>
                        </div>
                        <hr>
                        <div class="col-sm-12">
                            <h5>Transaction Hash(es)</h5>
                        </div>
                        <div class="col-sm-12" ng-if="!kyberEthToToken">
                            <a class="strong" ng-href="{{kyberTransaction.tokenTxLink}}" target="_blank" rel="noopener">
                                View
                                your
                                swap
                                transaction
                                <h5>{{kyberTransaction.tokenTxHash}}</h5>
                            </a>
                        </div>
                        <div class="col-sm-12" ng-if="!kyberEthToToken">
                            <a class="strong" ng-href="{{kyberTransaction.tokenApproveTxLink}}" target="_blank" rel="noopener">
                                View
                                your
                                token
                                authorization
                                transaction
                                <h5>{{kyberTransaction.tokenApproveTxHash}}</h5>
                            </a>
                        </div>
                        <div class="col-sm-12" ng-if="kyberEthToToken">
                            <a class="strong" ng-href="{{kyberTransaction.ethTxLink}}" target="_blank" rel="noopener">
                                View
                                your
                                transaction
                                <h5>{{kyberTransaction.ethTxHash}}</h5>
                            </a>
                        </div>
                    </section>
                </div>


            </div>

        </article>


    </article>

    <!-- / Swap Kyber 4-->
</article>