import React, { useEffect } from "react";

interface Props {
  textvar: string;
}

export const Textvar: React.FunctionComponent<Props> = ({ textvar }) => {
  const [_ignored, forceUpdate] = React.useReducer(x => x + 1, 0);
  const callback = (...args) => {
    forceUpdate(1);
  };

  useEffect(() => {
    Quby.textvars.on("change", callback);
  });

  return <span>{Quby.textvars.get(textvar)}</span>;
};
