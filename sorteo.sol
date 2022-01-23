// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// contrato nuevo de loteria
contract loteria
{
    // dos estados posibles
    enum Estado {Activa,Finalizado }
    // direccion Admin
    address public administrador;
    // payable pk se le va a pagar despues;
    address payable [] private participantes;
    // Estado loteria
    Estado public estado;
    address payable private ganador;

// el constructor se ejecuta una sola vez cuando se despliega el contrato
    constructor() public {
        // admin quien lo crea;
        administrador = msg.sender;
        // activar contrato
        estado = Estado.Activa;
    }

    function participar() public payable {

// requiere que sean 0.01 ethers para particioar
        require(msg.value == 0.01 ether, "participacion minima no hecha" );
        // Estado
        require(estado == Estado.Activa, "sorteo Finalizado");

        participantes.push(msg.sender);
    }
    function () external payable{
        participar();
    }

    function finalizarSorteo(){
        require(msg.sender == "administrador", "solo administrador")
        require(estado == "activo")
        estado = Estado.Finalizado;
        uint idGanador = random() %participantes.length;
        ganador =participantes[idGanador]
        ganador.transfer(address(this).balance)

    }

    function random() public view returns (uint){
        return uint valorAleatorio = uint(keccak256(abi.encodedPacked(block.tiestamp,block.difficulty,participantes.length)));
    }

    function getBalance public view  returns(uint){
        return address(this).balance;
    }

function getGanador public view returns(address payable){
  require (estado == Estado.Finalizado, "Aún no ha finalizado")
    return ganador;

}


}
