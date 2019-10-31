/// <reference types="jquery" />

export = Backbone;
export as namespace Backbone;

declare module Backbone {
  interface ModelFetchOptions {
    success: () => void;
    error: () => void;
  }

  interface EventHandler {
    (...args: any[]): void;
  }

  class Model<T> {
    get<K extends keyof T>(attributeName: K): T[K];
    set(attributes: Partial<T>): void;
    fetch(options?: ModelFetchOptions): JQueryXHR;
    on(event: string, callback: EventHandler, context?: any): Model<T>;
    off(event: string, callback: EventHandler, context?: any): Model<T>;
  }

  class Collection<T> {
    models: T[];
    length: number;
    fetch(): void;
    on(event: string, callback: EventHandler, context?: any): T;
    off(event: string, callback: EventHandler, context?: any): T;
  }
}
