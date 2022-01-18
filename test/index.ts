import { expect } from "chai";
import { ethers } from "hardhat";

// describe("Greeter", function () {
//   it("Should return the new greeting once it's changed", async function () {
//     const Greeter = await ethers.getContractFactory("Greeter");
//     const greeter = await Greeter.deploy("Hello, world!");
//     const [acc1, acc2] = await ethers
//     await greeter.deployed();

//     expect(await greeter.greet()).to.equal("Hello, world!");

//     const setGreetingTx = await greeter.setGreeting("Hola, mundo!");

//     // wait until the transaction is mined
//     await setGreetingTx.wait();

//     expect(await greeter.greet()).to.equal("Hola, mundo!");
//   });
// });

describe("Decimals", function () {
  it("Should return the dechimals once it's changed", async function () {
    const Greeter = await ethers.getContractFactory("ERC20");
    const greeter = await Greeter.deploy("ERC20", "ERC20");
    
    await greeter.deployed();
    
    expect(await greeter.decimals()).to.equal(18);
  });
});

