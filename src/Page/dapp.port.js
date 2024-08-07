let providers = {};

const registerPorts = app => {
  const chainIDtoName = async chainID => {
    try {
      const res = await (await fetch('https://chainid.network/chains_mini.json')).json();
      const chainData = res.find(chain => chain.chainId === parseInt(chainID, 16));
      return chainData?.name || 'Unknown';
    } catch (error) {
      console.error('Error fetching chain data: ', error);
      app.ports.receiveNotification.send({
        message: `Error fetching chain data.`,
        type: 'error'
      });
      return 'Unknown';
    }
  };

  app.ports.copyToClipboard.subscribe(text => {
    navigator.clipboard.writeText(text).catch(() => {
      app.ports.receiveNotification.send({
        message: `Error copying to clipboard.`,
        type: 'error'
      });
    });
  });

  window.addEventListener('eip6963:announceProvider', event => {
    providers[event.detail.info.uuid] = event.detail;
    const providerAnnouncement = {
      info: event.detail.info
    };
    app.ports.receiveNotification.send({
      message: `Provider ${event.detail.info.name} discovered.`,
      type: 'info'
    });
    app.ports.receiveProviderAnnouncement.send(providerAnnouncement);
  });

  app.ports.listProviders.subscribe(() => {
    window.dispatchEvent(new Event('eip6963:requestProvider'));
  });

  app.ports.connectWalletWithProvider.subscribe(async uuid => {
    if (uuid in providers) {
      try {
        const provider = providers[uuid];
        const proxy = providers[uuid].provider;
        const address = await proxy.request({ method: 'eth_requestAccounts' });
        const chainID = await proxy.request({
          method: 'eth_chainId'
        });
        const chainName = await chainIDtoName(chainID);
        const wallet = {
          uuid,
          address,
          chainID,
          chainName
        };
        proxy.on('disconnect', error => {
          app.ports.receiveWalletDisconnected.send(uuid);
          app.ports.receiveNotification.send({
            message: `Wallet ${provider.info.name} disconnected` + (error ? `: ${error.message}` : ''),
            type: 'error'
          });
        });

        app.ports.receiveWalletConnected.send(wallet);
      } catch (error) {
        console.error('Error connecting wallet: ', error);
        app.ports.receiveWalletNotConnected.send(uuid);
        app.ports.receiveNotification.send({
          message: `Error connecting wallet: ${error.message}`,
          type: 'error'
        });
      }
      return;
    }
    app.ports.receiveWalletNotConnected.send(uuid);
    app.ports.receiveNotification.send({
      message: `Provider not found.`,
      type: 'error'
    });
  });
};

export { registerPorts };
