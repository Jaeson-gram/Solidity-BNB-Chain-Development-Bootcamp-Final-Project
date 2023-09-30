window.addEventListener('load', async () => {
    if (window.ethereum) {
        window.web3 = new Web3(ethereum);
        try {
            await ethereum.enable();
        } catch (error) {
            console.error("User denied account access");
        }
    } else if (window.web3) {
        window.web3 = new Web3(web3.currentProvider);
    } else {
        console.error("No Web3 provider detected");
    }
});

const contractAddress = 'YOUR_CONTRACT_ADDRESS'; // Replace with the deployed contract address
const contractAbi = [ /* ABI of your contract */ ];

const contract = new web3.eth.Contract(contractAbi, contractAddress);

async function convertToken() {
    const amount = document.getElementById("amount").value;
    
    try {
        await contract.methods.convertToken(amount).send({ from: ethereum.selectedAddress });
        document.getElementById("result").textContent = `Conversion successful!`;
    } catch (error) {
        console.error(error);
        document.getElementById("result").textContent = `Conversion failed. Check console for details.`;
    }
}
