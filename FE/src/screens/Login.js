import React, { useState } from "react";
import { useNavigate } from 'react-router-dom';
import IniciarSesion from "./IniciarSesion";

import cuscoFondo from "../source/image/cuscoFondo.jpg";



function ContentSelection(props) {
  const { option } = props;

  if (option === "iniciarSesion") {
    return <IniciarSesion />;
  }
}

export default function AuthUser() {
  const [option] = useState("iniciarSesion");
  const navigate = useNavigate();

  function registroPage() {
    navigate('/registro');
  }
  function registroAfilPage() {
    navigate('/registro_afiliado');
  }
  return (
    <div style={styles.containerAuth}>
      <ContentSelection option={option} />
      <div style={styles.otherOption}>
        <div
          onClick={registroPage}
          onMouseLeave={leave}
          onMouseOver={over}
          style={styles.itemOOp}
        >
          Registrame como Turista
        </div>
        <div
          onClick={registroAfilPage}
          onMouseLeave={leave}
          onMouseOver={over}
          style={styles.itemOOp}
        >
          Registrame como Afiliado
        </div>
      </div>
    </div>
  );
}

function over(e) {
  e.target.style.backgroundColor = " rgb(29, 107, 143)";
  e.target.style.cursor = "pointer";
}

function leave(e) {
  e.target.style.backgroundColor = "rgb(29, 89, 143)";
}

const styles = {
  containerAuth: {
    backgroundImage: `url(${cuscoFondo})`,
    backgroundRepeat: "no-repeat",
    backgroundSize: "cover",
  },
  otherOption: {
    display: "flex",
    justifyContent: "center",
    alignItems: "center",
  },
  itemOOp: {
    backgroundColor: "rgb(29, 89, 143)",
    color: "white",
    padding: "10px",
    margin: "10px",
    borderRadius: "10px",
  },
};