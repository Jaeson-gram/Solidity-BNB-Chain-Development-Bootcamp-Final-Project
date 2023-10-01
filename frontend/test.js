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

const contractAddress = 'CONTRACT_ADDRESS'; // Replace with the deployed contract address
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

// Function to get the number of conversions
async function getConversionCount() {
    try {
        const contract = new web3.eth.Contract(abi, contractAddress);

        const count = await contract.methods.getConversionCount().call();
        
        document.getElementById("conversionCount").innerHTML = `Total Conversions: ${count}`;
    } catch (error) {
        console.error("Error fetching conversion count:", error);
    }
}

// Function to get conversion details by index
async function getConversionDetails() {
    try {
        const index = parseInt(prompt("Enter the index of the conversion:"));

        if (isNaN(index)) {
            alert("Please enter a valid index.");
            return;
        }

        const contract = new web3.eth.Contract(abi, contractAddress);

        const details = await contract.methods.getConversionDetails(index).call();

        const [user, amount, converted, fee] = details;

        document.getElementById("conversionDetails").innerHTML = `
            <strong>Conversion Details (Index ${index}):</strong><br>
            User: ${user}<br>
            Amount: ${amount}<br>
            Converted: ${converted}<br>
            Fee: ${fee}<br>
        `;
    } catch (error) {
        console.error("Error fetching conversion details:", error);
    }
}
